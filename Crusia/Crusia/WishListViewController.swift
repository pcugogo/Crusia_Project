//
//  WishListViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WishListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    var isLoadingPost = false
    var postData: [House] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewSetting()
        loadPosts()
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        configureLoadingIndicator()
        loadPosts()
        print("WishListViewwill appear ...........................................")
        
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureTableViewSetting() {
        tableView.estimatedRowHeight = 390.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = .clear
    }
    
    func configureLoadingIndicator() {
        
        // 로딩 애니메이션
        loadingIndicator.type = .ballBeat
        loadingIndicator.color = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
        
        loadingView.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func loadPosts() {
        
        WishListService.shared.requestWishList { (newPosts) in
            
            if self.postData.count != newPosts.count {
                self.postData = newPosts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    // 로딩 뷰 하이드
                    self.loadingView.isHidden = true
                    self.loadingIndicator.stopAnimating()
                }
                
            } else {
                // 로딩 뷰 하이드
                self.loadingView.isHidden = true
                self.loadingIndicator.stopAnimating()
            }
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
    
        loadingView.isHidden = false
        loadingIndicator.startAnimating()
        
        if WishListService.shared.heartIndex.contains(sender.tag) {
            let tempIndex = WishListService.shared.heartIndex.filter { $0 != sender.tag}
            WishListService.shared.heartIndex = tempIndex
        }
        
        WishListService.shared.addAndDeleteHouseToWishList(housePk: sender.tag)
        
        NotificationCenter.default.post(name: Notification.Name("WishChangedNoti"), object: "delete")

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.async {
                self.loadPosts()
            }
        }
    }
    
}












