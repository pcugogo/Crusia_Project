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
    
    var extraFeeInfo: [JSON] = []

    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ExtraFeeViewcontroller ..................................")
        print(extraFeeInfo)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
}
