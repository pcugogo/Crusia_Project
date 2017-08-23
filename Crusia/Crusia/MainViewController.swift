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
import NVActivityIndicatorView
import Toaster

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    var postData: [House] = []
    var searchResults: [House] = []
    var isLoadingPost = false
    let refreshControl = UIRefreshControl()
    var searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        print("MainViewController 에 들어옴 ......................")
        print("CurrentUserToken: \(UserDefaults.standard.object(forKey: "token") as! String)")
        
        // 로딩 애니메이션
        loadingIndicator.type = .ballBeat
        loadingIndicator.color = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)

        loadingIndicator.startAnimating()
        
        // Configure the pull to refresh
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.addTarget(self, action: #selector(loadRecentPosts), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        configureTableViewSetting()

        // Load recent posts
        loadWishList()
        loadRecentPosts()
        // configure search controller
        configureSearchController()
        
        configureToaster()
        
        // 키보드 노티
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.reloadTable), name: Notification.Name("WishChangedNoti"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.reloadTable), name: Notification.Name("WishChangedNotiFromMapView"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // configure navigation controller
        configureNavigationController()
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadWishList() {
        WishListService.shared.loadWishList()
    }
    
    func configureToaster() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                ToastView.appearance().backgroundColor = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
                ToastView.appearance().bottomOffsetPortrait = 300
                let userName = CurrentUserInfoService.shared.currentUser?.firstName.stringValue
                Toast(text: userName! + "님 환영합니다.", duration: Delay.long).show()
            }
        }
    }
    
    func configureNavigationController() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)

        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "위치를 입력하세요"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)

    }
    
    func configureTableViewSetting() {
        // Configure Dynamic cell height
        tableView.estimatedRowHeight = 390.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = .clear
    }
    
    // 필터링 데이터
    func filterContent(for searchText: String) {
        searchResults = postData.filter({ (house) -> Bool in
            if let address = house.address.string, let title = house.title.string  {
                let isMatch = address.localizedCaseInsensitiveContains(searchText) || title.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
    
    // MARK: - 포스트 다운로드, 디스플레이
    @objc func loadRecentPosts() {
        
        isLoadingPost = true
        
        PostService.shared.getRecentPost(start: postData.first?.pk.int, limit: 10) { (newPosts) in
            
            if newPosts.count > 0 {
                
                // 새로운 포스트 데이터를 postData 어레이 제일 앞에 넣는다.
                self.postData.insert(contentsOf: newPosts, at: 0)
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

//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
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
        loadingIndicator.stopAnimating()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPostDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let destinationController = segue.destination as! DetailViewController
                
                destinationController.house = (searchController.isActive) ? searchResults[indexPath.row] : postData[indexPath.row]
//                destinationController.house = postData[indexPath.row]
                
            }
        }
    }
}

// MARK: - TableView Setting
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            return searchResults.count
        } else {
            return postData.count
        }
//        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainTableViewCell
        
        // 분기 처리
        let currentPost = (searchController.isActive) ? searchResults[indexPath.row] : postData[indexPath.row]
        let housePk: Int = currentPost.pk.numberValue as! Int
        
        cell.configure(post: currentPost)

        // 위시리스트 추가 기능
        cell.heartButton.tag = currentPost.pk.numberValue as! Int
        cell.heartButton.addTarget(self, action: #selector(handleLikes(sender:)), for: .touchUpInside)
        
        if WishListService.shared.heartIndex.contains(housePk) {
            cell.heartButton.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
        } else {
            cell.heartButton.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 무한 로딩
        // 마지막 포스트 두개에 도달했을 때 더 오래된 포스트 로딩
        guard !isLoadingPost, postData.count - indexPath.row == 2 else {
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
//                self.heartImages.append(#imageLiteral(resourceName: "heart2"))
//                WishListService.shared.heartIndex.append(newPost.pk.numberValue as! Int)
//                WishListService.shared.heartImages.append(#imageLiteral(resourceName: "heart2"))

                print("하트 숫자.............................................................")
//                print(self.heartImages.count)
                
                let indexPath = IndexPath(row: self.postData.count - 1, section: 0)
                
                indexPaths.append(indexPath)
            }
            
            DispatchQueue.main.async {
                self.tableView.insertRows(at: indexPaths, with: .fade)
                self.tableView.endUpdates()
                self.isLoadingPost = false
            }
        }
    }
    
    // 위시리스트 추가, 삭제
    func handleLikes(sender: AnyObject){
        
        // 추가
        if !WishListService.shared.heartIndex.contains(sender.tag) {
            WishListService.shared.heartIndex.append(sender.tag)
            sender.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
            WishListService.shared.addAndDeleteHouseToWishList(housePk: sender.tag)

        
        // 삭제
        } else {
            
            if WishListService.shared.heartIndex.contains(sender.tag) {
                let tempIndex = WishListService.shared.heartIndex.filter { $0 != sender.tag}
                WishListService.shared.heartIndex = tempIndex
            }

            sender.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
            WishListService.shared.addAndDeleteHouseToWishList(housePk: sender.tag)
        }
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
}






