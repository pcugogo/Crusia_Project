//
//  ReservationStepTwoViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ReservationStepTwoViewController: UIViewController {

    @IBOutlet weak var rullLabel: UILabel!
    @IBOutlet weak var guidelineLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInfo()
        configureTableView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureInfo() {
        guard let hostName = ReservationService.shared.host?.firstName.stringValue else  { return }
        self.rullLabel.text = "\(hostName)님의 숙소 이용규칙 확인하기"
        self.guidelineLabel.text = "다음은 \(hostName)님의 숙소에서 지켜야 할 가이드라인과 숙지할 사항입니다."
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        guard let house = ReservationService.shared.house else { return }
        
        // 예약 날짜가 없을 경우
        let price: String = String(house.pricePerDay.intValue)
        self.priceLabel.text = "￦" + price
        self.dateLabel.text = "/1박"
        
        // 예약 날짜가 있을 경우
        if let selectedDates = ReservationService.shared.selectedDates {
            let price: String = String(house.pricePerDay.intValue * selectedDates)
            self.priceLabel.text = "￦" + price
            self.dateLabel.text = "\(selectedDates)박"
        }
    }
    
    // 테이블뷰 세팅
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        // 안쓰는 테이블 로우 줄 지우기
//        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        // 스크롤링 안되게 만들기
//        tableView.isScrollEnabled = false
//        tableView.rowHeight = 111.0
    }
    
    // 네비게이션바 세팅
    func configureNavigationbar() {
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.view.backgroundColor = UIColor.clear
        
//        navigationController?.navigationBar.isHidden = false
//        navigationController?.setNavigationBarHidden(false, animated: true)
        //        navigationController?.hidesBarsOnSwipe = true
        
//        self.tabBarController?.tabBar.isHidden = true
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    

}

extension ReservationStepTwoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIentifier = "ReservationStepTwoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIentifier, for: indexPath) as! ReservationStepTwoCell
        
        switch indexPath.row {
            
        case 0:
            
            let info = "체크인은 14:00 이후입니다."
            cell.configureCell(info: info)
            
            return cell
        case 1:
            let info = "Enjoy and respect the property \n\nCourteous and friendly to fellow guests on the property"
            cell.configureCell(info: info)
            tableView.estimatedRowHeight = 80.0
            tableView.rowHeight = UITableViewAutomaticDimension

            return cell
            
        case 2:
            let info = "회원님의 첫 크루시아 여행을 위한 도움말: \n\n각 숙소만의 특징이 있으며, 공간과 편의시설이 숙소마다 다릅니다."
            cell.configureCell(info: info)

            return cell
            
        case 3:
            let info = "숙소를 존중하는 마음으로 이용해 주세요. 호스트의 소중한 집이니까요."
            cell.configureCell(info: info)

            return cell
        case 4:
            let info = "숙박 전과 숙박 기간 중에 호스트와 활발히 소통하세요."
            cell.configureCell(info: info)
            
            return cell
        default:
            
            return cell
        }
    }
}
