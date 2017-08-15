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
        
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
//        loadRecentPosts()
        loadPosts()
        tableView.reloadData()
        print("WishListViewwill appear ...........................................")
        
        for i in postData {
            print(i.pk)
        }
        
        self.tabBarController?.tabBar.isHidden = false

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadPosts() {
        WishListService.shared.getWishList { (newPosts) in
            
            self.postData = newPosts
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
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(handleLikes(sender:)), for: .touchUpInside)
        //        cell.heartButton.setImage(heartImages[indexPath.row], for: .normal)
//        cell.heartButton.setImage(WishListService.shared.heartImages[indexPath.row], for: .normal)

        
        
        return cell
    }
    

    
    // 위시리스트 추가, 삭제
    func handleLikes(sender: AnyObject){
        
        

        
    }
    
}












