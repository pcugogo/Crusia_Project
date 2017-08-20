//
//  ExtraFeeViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class ExtraFeeViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var extraFeeInfo: [JSON] = []
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ExtraFeeViewcontroller ..................................")
        print(extraFeeInfo)
        self.configureTableView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureTableView() {
        // 안쓰는 테이블 로우 줄 지우기
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }


}

extension ExtraFeeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return extraFeeInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExtraFeeCustomCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExtraFeeCustomCell
        
        cell.configure(data: extraFeeInfo, indePath: indexPath.row)
        cell.selectionStyle = .none
        
        tableView.rowHeight = 80.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // fade in
        // 처음 상태
        cell.alpha = 0
        
        // 마지막 상태
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
        }
        
        // rotating
        // 처음 상태
        let rotationAngleInRadians = 90.0 * CGFloat(Double.pi/180.0)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
        cell.layer.transform = rotationTransform
        
        // 마지막 상태
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
        
    }

}
