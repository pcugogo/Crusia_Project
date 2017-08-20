//
//  ReservationStepOneViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Kingfisher

class ReservationStepOneViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureInformation()
//        configureTableView()
        configureNavigationbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureInformation()
        configureTableView()
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // 현재 예약 정보 불러오기
    func configureInformation() {
        
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
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // 스크롤링 안되게 만들기
        tableView.isScrollEnabled = false
        tableView.rowHeight = 111.0
    }
    
    // 네비게이션바 세팅
    func configureNavigationbar() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
        
        self.tabBarController?.tabBar.isHidden = true
        //        self.navigationController?.navigationBar.isTranslucent = true
//        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reservationViewFromStepOne" {
            let destinationController = segue.destination as! HSReservationViewController
            if let house = ReservationService.shared.house {
                destinationController.currentHousePk = house.pk.numberValue as! Int
            }
        }
    }

}

extension ReservationStepOneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let reuseIentifier = "ReservationStepOneHouseInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIentifier, for: indexPath) as! ReservationStepOneHouseInfoCell
            tableView.rowHeight = 111.0
            
            return cell
        case 1:
            let reuseIentifier = "ReservationStepOneCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIentifier, for: indexPath) as! ReservationStepOneCell
            tableView.rowHeight = 80.0

            return cell
        default:
            let reuseIentifier = "ReservationStepOneCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIentifier, for: indexPath) as! ReservationStepOneCell
            return cell
        }
    }
}
