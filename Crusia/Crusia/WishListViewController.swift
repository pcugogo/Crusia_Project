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
    
//        loadRecentPosts()
        loadPosts()
        tableView.reloadData()
        print("WishListViewwill appear ...........................................")
        
        for i in postData {
            print(i.pk)
        }
    
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
        
        if segue.identifier == "showPostDetail" {
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
        
        
        return cell
    }
    
}












