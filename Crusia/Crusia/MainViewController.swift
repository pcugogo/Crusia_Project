//
//  MainViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 3..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var heartImages: [UIImage] = []
    var postData: [House] = []
    var isLoadingPost = false
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        print("MainViewController 에 들어옴 ......................")
        print("CurrentUserToken: \(UserDefaults.standard.object(forKey: "token") as! String)")
        
        // Configure the pull to refresh
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.addTarget(self, action: #selector(loadRecentPosts), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        // Configure Dynamic cell height
        tableView.estimatedRowHeight = 390.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = .clear

        // Configure Navigationbar
//        let backItem = UIBarButtonItem()
//        backItem.title = ""
//        backItem.tintColor = .clear
//        self.navigationController?.navigationItem.backBarButtonItem = backItem

        // Load recent posts
        loadRecentPosts()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - 포스트 다운로드, 디스플레이
    @objc func loadRecentPosts() {
        
        isLoadingPost = true
        
        PostService.shared.getRecentPost(start: postData.first?.pk.int, limit: 10) { (newPosts) in
            
            if newPosts.count > 0 {
                
                // 새로운 포스트 데이터를 postData 어레이 제일 앞에 넣는다.
                self.postData.insert(contentsOf: newPosts, at: 0)
                self.heartImages = [UIImage](repeating: #imageLiteral(resourceName: "heart2"), count: newPosts.count)
            }
            
            self.isLoadingPost = false
            
            if self.refreshControl.isRefreshing {
                
                // Delay 0.5 second before ending the refreshing in order to make the animation look better
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    
                    self.refreshControl.endRefreshing()
                    self.displayNewPosts(newPosts: newPosts)
                })
            } else {
                
                self.displayNewPosts(newPosts: newPosts)
            }
            print("하트 숫자.............................................................")
            print(self.heartImages.count)
        }
    }
    
    private func displayNewPosts(newPosts posts: [House]) {
        
        guard posts.count > 0 else {
            return
        }
        
        // 새로운 Post를 테이블에 add 한다.
        var indexPaths: [IndexPath] = []
        
        self.tableView.beginUpdates()
        
        for num in 0...(posts.count - 1) {
            
            let indexPath = IndexPath(row: num, section: 0)
            indexPaths.append(indexPath)
        }
        
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
        
        // 테이블 로드 전 애니메이션 뷰
        emptyView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPostDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let destinationController = segue.destination as! DetailViewController
                destinationController.house = postData[indexPath.row]
                
            }
        }
    }
}

// MARK: - TableView Setting
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainTableViewCell
        
        let currentPost = postData[indexPath.row]
        
        cell.configure(post: currentPost)

        // 위시리스트 추가 기능
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(handleLikes(sender:)), for: .touchUpInside)
        cell.heartButton.setImage(heartImages[indexPath.row], for: .normal)

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 무한 로딩
        // 마지막 포스트 두개에 도달했을 때 더 오래된 포스트 로딩
        guard !isLoadingPost, postData.count - indexPath.row == 3 else {
            return
        }
        
        isLoadingPost = true
        
        guard let lastPostTimestamp = postData.last?.pk.int else {
            
            isLoadingPost = false
            return
        }
        
        PostService.shared.getOldPosts(start: lastPostTimestamp, limit: 3) { (newPosts) in
            
            // 기존 어레이에 새로운 포스트를 추가한다
            var indexPaths: [IndexPath] = []
            
            self.tableView.beginUpdates()
            
            for newPost in newPosts {
                
                self.postData.append(newPost)
                self.heartImages.append(#imageLiteral(resourceName: "heart2"))
                print("하트 숫자.............................................................")
                print(self.heartImages.count)
                
                let indexPath = IndexPath(row: self.postData.count - 1, section: 0)
                
                indexPaths.append(indexPath)
            }
            

            
            self.tableView.insertRows(at: indexPaths, with: .fade)
            self.tableView.endUpdates()
            
            self.isLoadingPost = false
        }
    }
    
    // 위시리스트 추가, 삭제
    func handleLikes(sender: AnyObject){
        
        if heartImages[sender.tag] == #imageLiteral(resourceName: "heart1") {
            heartImages[sender.tag] = #imageLiteral(resourceName: "heart2")
            WishListService.shared.delete(house: postData[sender.tag])
        } else {
            heartImages[sender.tag] = #imageLiteral(resourceName: "heart1")
            WishListService.shared.add(house: postData[sender.tag])
        }
        
        sender.setImage(heartImages[sender.tag], for: .normal)
        
    }
}













