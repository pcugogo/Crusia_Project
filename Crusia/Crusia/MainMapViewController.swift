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
import MapKit

class MainMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewForMap: GMSMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var heartImages: [UIImage] = []
    var postData: [House] = []
    var isLoadingPost = false
    var displayMarker = GMSMarker()
    var mapPin: [MKPointAnnotation] = []
    var indexPathOfCurrent: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스크롤뷰 인셋 삭제
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)

        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // Make the colleciton view transparent
        collectionView.backgroundColor = UIColor.clear
        
        loadRecentPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
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
                    self.configureLocationOf(house: i)
                }
                self.heartImages = [UIImage](repeating: #imageLiteral(resourceName: "heart2"), count: newPosts.count)
                
                WishListService.shared.heartImages = [UIImage](repeating: #imageLiteral(resourceName: "heart2"), count: newPosts.count)
            }
            
            self.isLoadingPost = false
            self.collectionView.isHidden = false
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            
            DispatchQueue.main.async {
            self.collectionView.reloadData()
            
            
            // 로딩시 첫 카메라 위치
            let currentPost = self.postData[0]
            let lat = currentPost.latitude.numberValue as! Double
            let long = currentPost.longitude.numberValue as! Double
            let location = CLLocation(latitude: lat, longitude: long)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000.0, 5000.0)
            
            
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.mapView.selectAnnotation(self.mapPin[0], animated: true)
            }
            
        }
    }
    
    // 마커 표시 (구글맵)
//    func displayMarkerfor(house: House) {
//        let marker = GMSMarker()
//        let lat = house.latitude.numberValue as! Double
//        let long = house.longitude.numberValue as! Double
//        marker.position = CLLocationCoordinate2DMake(lat,long)
//        marker.title = house.pricePerDay.stringValue
//        marker.snippet = house.title.stringValue
//        self.displayMarker = marker
//        displayMarker.map = self.viewForMap
////        marker.map = self.viewForMap
//    }
    
    // 마커표시 (mapkit)
    func configureLocationOf(house: House) {
        
        if let lat = house.latitude.double, let long = house.longitude.double {
            
            let location = CLLocation(latitude: lat, longitude: long)
            let pin = MKPointAnnotation()
            
            // 가격에 , 찍기
            if let price = house.pricePerDay.int {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value:price))
                
                pin.title = "￦" + formattedNumber!
            }
            
            pin.coordinate = location.coordinate
            
            self.mapPin.append(pin)
            mapView.addAnnotation(pin)
            mapView.showAnnotations([pin], animated: true)
        }

    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        assert(sender as? UICollectionViewCell != nil, "sender is not a collection view")
        
        if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
            if segue.identifier == "showDetailFromMapView" {
                let destinationController = segue.destination as! DetailViewController
                destinationController.house = postData[indexPath.row]
            }
        } else {
            // Error sender is not a cell or cell is not in collectionView.
        }
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
                
                let indexPath = IndexPath(row: self.postData.count - 1, section: 0)
                
                indexPaths.append(indexPath)
                
                // 마커 표시
                self.configureLocationOf(house: newPost)
            }
            
            
            collectionView.reloadData()

            self.isLoadingPost = false
        }
    }
    
    // 커스텀 셀 Paging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee = scrollView.contentOffset
        var cellToSwipe: Int = Int(scrollView.contentOffset.x/250 + 0.5)
        
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= postData.count {
            cellToSwipe = postData.count - 1
        }

        var indexPath = IndexPath(row: cellToSwipe, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        // 현재 위치로 지도뷰 카메라 이동
        let currentPost = postData[indexPath.row]
        let lat = currentPost.latitude.numberValue as! Double
        let long = currentPost.longitude.numberValue as! Double
        let location = CLLocation(latitude: lat, longitude: long)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000.0, 5000.0)

        mapView.setRegion(coordinateRegion, animated: true)
        self.mapView.selectAnnotation(mapPin[indexPath.row], animated: true)
    }
    
    
    
    // 위시리스트 추가, 삭제
    func handleLikes(sender: AnyObject){
        
        // 위시리스트에 있는 상태
        
        if !WishListService.shared.heartIndex.contains(sender.tag) {
            WishListService.shared.heartIndex.append(sender.tag)
            
            sender.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
            //            // 서버 데이터 통신 - 삭제
            
            WishListService.shared.addAndDeleteHouseToWishList(housePk: sender.tag)
            
        } else {
            for i in 0...WishListService.shared.heartIndex.count - 1 {
                if WishListService.shared.heartIndex[i] == sender.tag {
                    WishListService.shared.heartIndex.remove(at: i)
                }
            }
            
            sender.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
            //            // 서버 데이터 통신 - 추가
            WishListService.shared.addAndDeleteHouseToWishList(housePk: sender.tag)
        }
        
        // 메인 테이블에 위시리스트 변경 노티
        NotificationCenter.default.post(name: Notification.Name("WishChangedNotiFromMapView"), object: "delete")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
////            performSegue(withIdentifier: "showDetailFromMapView", sender: cell)
//        } else {
//            // Error indexPath is not on screen: this should never happen.
//        }
    }
    
}

