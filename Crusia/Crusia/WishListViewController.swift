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
        
        loadPosts()

        tableView.estimatedRowHeight = 390.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = .clear
        
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
//        loadRecentPosts()
        loadPosts()
        print("WishListViewwill appear ...........................................")
        
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadPosts() {
        
        WishListService.shared.requestWishList { (newPosts) in
            
            self.postData = newPosts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            for i in self.postData {
                print("로드포스트 안 ..........")
                print(i.pk.numberValue)
            }
            
            print("하트 인덱스 프린트.....")
            print(WishListService.shared.heartIndex)
            
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailFromWishList" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let destinationController = segue.destination as! DetailViewController
                destinationController.house = postData[indexPath.row]
                
            }
        }
    }
    
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
                
        // 위시리스트 추가 기능
        cell.heartButton.tag = currentPost.pk.numberValue as! Int
        cell.heartButton.addTarget(self, action: #selector(handleLikes(sender:)), for: .touchUpInside)

        return cell
    }
    

    
    // 위시리스트 삭제
    func handleLikes(sender: AnyObject){
    
        
        
        WishListService.shared.addAndDeleteHouseToWishList(housePk: sender.tag)
        
        NotificationCenter.default.post(name: Notification.Name("WishChangedNoti"), object: "delete")

        loadPosts()
    }
    
}












