//
//  WishListViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var isLoadingPost = false
    var postData: [House] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 390.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = .clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        loadRecentPosts()
        tableView.reloadData()
        print("WishListViewwill appear ...........................................")
        
        for i in postData {
            print(i.pk)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 포스트 다운로드, 디스플레이
    @objc func loadRecentPosts() {
        
        isLoadingPost = true
        
        WishListService.shared.getWishList { (newPosts) in
            
            if newPosts.count > 0 {
                
                // 새로운 포스트 데이터를 postData 어레이 제일 앞에 넣는다.
                self.postData = newPosts
//                self.postData.insert(contentsOf: newPosts, at: 0)
            }
            
            self.isLoadingPost = false
//            self.displayNewPosts(newPosts: newPosts)
        }
    }
    
//    private func displayNewPosts(newPosts posts: [House]) {
//        
//        guard posts.count > 0 else {
//            return
//        }
//        
//        // 새로운 Post를 테이블에 add 한다.
//        var indexPaths: [IndexPath] = []
//        
//        self.tableView.beginUpdates()
//        
//        for num in 0...(posts.count - 1) {
//            
//            let indexPath = IndexPath(row: num, section: 0)
//            indexPaths.append(indexPath)
//        }
//        
//        self.tableView.insertRows(at: indexPaths, with: .fade)
//        self.tableView.endUpdates()
//        
//        // 테이블 로드 전 애니메이션 뷰
////        emptyView.isHidden = true
//    }
    
}


extension WishListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "WishCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WishListTableViewCell
        
        let currentPost = postData[indexPath.row]
        
        cell.configure(post: currentPost)
        
        
        return cell
    }
    
}












