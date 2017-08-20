//
//  ReservationStepFourViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Kingfisher

class ReservationStepFourViewController: UIViewController {

    @IBOutlet weak var hostNanme: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var startDate: String = ""
    var endDate: String = ""
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInfo()
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureInfo() {
        
        // 날짜 설정
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.dateLabel.text = "예약 가능일 알아보기"
        
        if let checkInDate = ReservationService.shared.checkInDate, let checkOutDate = ReservationService.shared.checkOutDate{
            
            formatter.dateFormat = "M'월' dd'일'"
            self.startDate = formatter.string(from: checkInDate)
            formatter.dateFormat = "dd'일'"
            self.endDate = formatter.string(from: checkOutDate)
            
            self.dateLabel.text = startDate + "~" + endDate
        }
        
        // 호스트네임과 집 타입
        
        if let name = ReservationService.shared.host?.firstName.stringValue, let type = ReservationService.shared.house?.roomType.stringValue {
            self.hostNanme.text = name + "님의 " + type
        }

        
        // 하우스 이미지
        self.houseImageView.image = #imageLiteral(resourceName: "Flat")
        
        if let url = ReservationService.shared.house?.houseImages[0]["image"].url {
            self.houseImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_bg"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
    }
    
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        // 안쓰는 테이블 로우 줄 지우기
//        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // 스크롤링 안되게 만들기
//        tableView.isScrollEnabled = false
//        tableView.rowHeight = 111.0
    }
}

extension ReservationStepFourViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let reuseIdentifier = "RSFourAvailableCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RSFourAvailableCell
            
            tableView.rowHeight = 80.0
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let reuseIdentifier = "RSFourPriceCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RSFourPriceCell
            
            tableView.rowHeight = 240.0
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let reuseIdentifier = "RSFourRefundInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RSFourRefundInfoCell
            
            tableView.rowHeight = 176.0
            cell.selectionStyle = .none
            return cell
            
        case 3:
            let reuseIdentifier = "RSFourPolicyCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RSFourPolicyCell
            
            tableView.rowHeight = 111.0
            cell.selectionStyle = .none
            return cell
            
        default:
            let reuseIdentifier = "RSFourAvailableCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RSFourAvailableCell
            
            return cell
        }
    }
}










