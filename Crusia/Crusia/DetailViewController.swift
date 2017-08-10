//
//  DetailViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pricePerDayLabe: UILabel! {
        didSet {
            
            if let price = house.pricePerDay.int {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value:price))
                
                pricePerDayLabe.text = "￦" + formattedNumber!
            }
        }
    }
    @IBOutlet weak var reserveButton: UIButton! {
        didSet {
            reserveButton.layer.cornerRadius = 3
        }
    }
    
    var house: House!
    var isHouseInfoCellExtended: Bool = false
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("여기는 DetailViewCon .......")
        
//        print(house)
        tableView.estimatedRowHeight = 140.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.hidesBarsOnSwipe = true
        
        self.tabBarController?.tabBar.isHidden = true
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMap() {
        performSegue(withIdentifier: "showMapView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Amenites 목록 전달
        if segue.identifier == "showAmenitiesView" {
            
            let destinationController = segue.destination as! AmenitiesViewController
            destinationController.amenities = house.amenities
            
        } else if segue.identifier == "showExtraFeeView" {
            
            // Extra Fee 정보 전달
            let destinationController = segue.destination as! ExtraFeeViewController
            
            var extraInfo: [JSON] = []
            
            extraInfo.append(house.extraPeopleFee)
            extraInfo.append(house.cleaningFee)
            extraInfo.append(house.weeklyDiscount)
            
            destinationController.extraFeeInfo = extraInfo
            
        } else if segue.identifier == "showDetailedUserInfo" {
            
            // User Info 정보 전달
            let destinationController = segue.destination as! DetailedUserInfoViewController
            
            destinationController.userInfo = house.host
        } else if segue.identifier == "showMapView" {
            
            let destinationcontroller = segue.destination as! MapViewController
            destinationcontroller.house = house
            

            
        } else {
            
        }
    }
    
    @IBAction func backBtnTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 에약하기
    @IBAction func makeReservationButton(_ sender: UIButton) {
        
        // 아직 미구현
        
        let alertController = UIAlertController(title: "미구현", message: "아직 구현되지 않았습니다.. 😭😭😭", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okayAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}


// 테이블 뷰 관련
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        
        // User 정보
        case 0:
            
            let reuseIdentifier = "UserInfoCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserInfoCustomCell
            
            cell.configure(post: house)
            cell.selectionStyle = .none
            
            return cell
        
        // 하우스 요약 정보
        case 1:
            
            let reuseIdentifier = "FirstCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FirstCustomCell
            
            cell.configure(post: house)
            cell.selectionStyle = .none
            
            return cell

        // 최소 숙박일
        case 2:
            
            let reuseIdentifier = "SecondCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SecondCustomCell
            
            cell.configure(post: house)
            cell.selectionStyle = .none
//            tableView.rowHeight = 80
            
            return cell
            
        // House 정보
        case 3:
            
            let reuseIdentifier = "HouseInfoCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HouseInfoCustomCell
            
            cell.configure(houseInfo: house)
            
            if isHouseInfoCellExtended {
                
                cell.houseInfoLabel.numberOfLines = 0
                cell.readMoreLabel.textColor = .clear
                
            } else {
                
                cell.houseInfoLabel.numberOfLines = 3
                
                if let count = cell.houseInfoLabel.text?.characters.count, count <= 106 {
                    cell.readMoreLabel.textColor = .clear
                }
                
                tableView.estimatedRowHeight = 130.0
                tableView.rowHeight = UITableViewAutomaticDimension
                
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        // 지도 정보
        case 4:
            
            let reuseIdentifier = "MapViewCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MapViewCustomCell
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
            cell.mapView.addGestureRecognizer(tapGestureRecognizer)
            
            cell.configure(house: house)
            cell.selectionStyle = .none
            
            return cell
            
        // 체크인 / 체크아웃 시간 정보
        case 5:
            
            let reuseIdentifier = "CheckInOutCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CheckInOutCustomCell
            
            cell.selectionStyle = .none
            
            return cell
            
        // Extra Fee 정보
        case 6:
            
            let reuseIdentifier = "ExtraFeeCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExtraFeeCustomCell
            
//            tableView.rowHeight = 80.0
            cell.selectionStyle = .none
            
            return cell
            
        // Refund 정보
        case 7:
            
            let reuseIdentifier = "RefundInfoCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RefundInfoCustomCell
            
            
//            tableView.rowHeight = 120.0
            cell.selectionStyle = .none
            
            return cell
            
        // Amenities 정보
        case 8:
            
            let reuseIdentifier = "ThirdCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ThirdCustomCell
            
            cell.configure(post: house)
            cell.selectionStyle = .none
            
            return cell
            
        // 엄격 환불 정책 정보
        case 9:
            
            let reuseIdentifier = "RefundPolicyCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RefundPolicyCustomCell
            
            cell.selectionStyle = .none
            
            return cell
            
            
        default:
            let reuseIdentifier = "SecondCustomCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SecondCustomCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard !isHouseInfoCellExtended else { return }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? HouseInfoCustomCell else { return }
        
        cell.houseInfoLabel.numberOfLines = 0
        cell.readMoreLabel.textColor = .clear
        
        isHouseInfoCellExtended = true
        
        tableView.beginUpdates()
        
        tableView.estimatedRowHeight = 140.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.endUpdates()
        
//        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return house.houseImages.array?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "ImagesCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HouseImagesCollectionViewCell
        
        
        if let url = house.houseImages[indexPath.row]["image"].url {
            cell.configure(imageURL:  url)
        }
        
        return cell
    }
    
    // image size를 collectionview size에 맞춘다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height:(collectionView.frame.height))
    }
    
}
