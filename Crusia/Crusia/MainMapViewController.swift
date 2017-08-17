//
//  MainMapViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 16..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import GoogleMaps
import NVActivityIndicatorView

class MainMapViewController: UIViewController {

    @IBOutlet weak var viewForMap: GMSMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var heartImages: [UIImage] = []
    var postData: [House] = []
    var isLoadingPost = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // Make the colleciton view transparent
        collectionView.backgroundColor = UIColor.clear
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        
//        let width = super.view.frame.size.width
//        let height = super.view.frame.size.height - backgroundImageView.frame.size.height
//        
//        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: width, height: height), camera: camera)
//        
////        let mapView = GMSMapView.map(withFrame: viewForMap.bounds, camera: camera)
//        viewForMap.addSubview(mapView)
//        
//        mapView.settings.myLocationButton = true
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//        
//        
//        let marker2 = GMSMarker()
//        marker2.position = CLLocationCoordinate2D(latitude: 37.515364, longitude: 127.096749)
//        marker2.title = "우리집"
//        marker2.snippet = "잠실"
//        marker2.map = mapView
        
        loadRecentPosts()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - 포스트 다운로드, 디스플레이
    @objc func loadRecentPosts() {
        
        collectionView.isHidden = true
        isLoadingPost = true
        
        // 로딩 애니메이션
        activityIndicatorView.type = .ballBeat
        activityIndicatorView.color = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
        activityIndicatorView.startAnimating()
        
        PostService.shared.getRecentPost(start: postData.first?.pk.int, limit: 10) { (newPosts) in
            
            if newPosts.count > 0 {
            
                // 새로운 포스트 데이터를 postData 어레이 제일 앞에 넣는다.
                self.postData.insert(contentsOf: newPosts, at: 0)
                
                for i in newPosts {
        
                    self.displayMarkerfor(house: i)
                }
                
                self.heartImages = [UIImage](repeating: #imageLiteral(resourceName: "heart2"), count: newPosts.count)
                
                WishListService.shared.heartImages = [UIImage](repeating: #imageLiteral(resourceName: "heart2"), count: newPosts.count)
            }
            
            self.isLoadingPost = false
            self.collectionView.isHidden = false
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            
            self.collectionView.reloadData()
            
//            self.displayNewPosts(newPosts: newPosts)
            
            print("하트 숫자.............................................................")
        }
    }
    
    // 마커 표시
    func displayMarkerfor(house: House) {
        let marker = GMSMarker()
        let lat = house.latitude.numberValue as! Double
        let long = house.longitude.numberValue as! Double
        marker.position = CLLocationCoordinate2DMake(lat,long)
        marker.title = house.pricePerDay.stringValue
        marker.snippet = house.title.stringValue
        marker.map = self.viewForMap
        
    }


}


extension MainMapViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "Cell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainMapCollectionViewCell
        
        let currentPost = postData[indexPath.row]
        
        cell.configure(post: currentPost)
        
        let lat = currentPost.latitude.numberValue as! Double
        let long = currentPost.longitude.numberValue as! Double
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        viewForMap.camera = GMSCameraPosition.camera(withTarget: location, zoom: 11)

        
//        // 마커 표시
//        let marker = GMSMarker()
//
//        let lat = currentPost.latitude.numberValue as! Double
//        let long = currentPost.longitude.numberValue as! Double
//        marker.position = CLLocationCoordinate2DMake(lat,long)
//        marker.title = currentPost.pricePerDay.stringValue
//        marker.snippet = currentPost.title.stringValue
//        marker.map = viewForMap
        
        
//
//        viewForMap.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 10)
//
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
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
            
            
            for newPost in newPosts {
                
                self.postData.append(newPost)
                self.heartImages.append(#imageLiteral(resourceName: "heart2"))
                WishListService.shared.heartImages.append(#imageLiteral(resourceName: "heart2"))
                
                print("하트 숫자.............................................................")
                //                print(self.heartImages.count)
                
                let indexPath = IndexPath(row: self.postData.count - 1, section: 0)
                
                indexPaths.append(indexPath)
                
                // 마커 표시
                self.displayMarkerfor(house: newPost)
                
            }
            
            
            collectionView.reloadData()

            self.isLoadingPost = false
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //      if let collectionView = collectionView {
        targetContentOffset.pointee = scrollView.contentOffset
        var cellToSwipe: Int = Int(scrollView.contentOffset.x/250 + 0.5)
        
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= postData.count {
            cellToSwipe = postData.count - 1
        }
        
        collectionView.scrollToItem(at: IndexPath(row: cellToSwipe, section: 0), at: .left, animated: true)
        
        
//        
//        targetContentOffset.pointee = scrollView.contentOffset
//        var factor: CGFloat = 0.5
//        if velocity.x < 0 {
//            factor = -factor
//        }
//        let indexPath = IndexPath(row: Int(scrollView.contentOffset.x/250 + factor), section: 0)
//        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
//        
//        
//        // set acceleration to 0.0
//        let pageWidth = Float(collectionView.bounds.size.width)
//        let minSpace: Int = 20
//        var cellToSwipe: Int = (scrollView.contentOffset.x) / (pageWidth + minSpace) + 0.5
//        // cell width + min spacing for lines
//        if cellToSwipe < 0 {
//            cellToSwipe = 0
//        }
//        else if cellToSwipe >= articles.count {
//            cellToSwipe = articles.count - 1
//        }
//        
//        articlesCollectionView.scrollToItem(at: IndexPath(row: cellToSwipe, section: 0), at: .left, animated: true)
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        targetContentOffset.pointee = scrollView.contentOffset
//        var factor: CGFloat = 0.5
//        if velocity.x < 0 {
//            factor = -factor
//        }
//        let indexPath = IndexPath(row: Int((scrollView.contentOffset.x/200 + factor)), section: 0)
//        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
//    }
    
    
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        targetContentOffset.pointee = scrollView.contentOffset
//        var factor: CGFloat = 0.5
//        if velocity.x < 0 {
//            factor = -factor
//        }
//        let indexPath = IndexPath(row: (scrollView.contentOffset.x/cellSize.width + factor).int, section: 0)
//        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
//    }
    
    
    
    // 위시리스트 추가, 삭제
    func handleLikes(sender: AnyObject){
        
        if WishListService.shared.heartImages[sender.tag] == #imageLiteral(resourceName: "heart1") {
            WishListService.shared.heartImages[sender.tag] = #imageLiteral(resourceName: "heart2")
            WishListService.shared.delete(house: postData[sender.tag])
            
            
        } else {
            WishListService.shared.heartImages[sender.tag] = #imageLiteral(resourceName: "heart1")
            WishListService.shared.add(house: postData[sender.tag])
            WishListService.shared.heartIndex.append(sender.tag)
            
        }
        
        sender.setImage(WishListService.shared.heartImages[sender.tag], for: .normal)
        
    }
}


