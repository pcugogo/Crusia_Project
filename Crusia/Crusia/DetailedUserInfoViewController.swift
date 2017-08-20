//
//  DetailedUserInfoViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class DetailedUserInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userInfo: User!
    var isUserInfoCellExtended: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureTableView() {
        // 안쓰는 테이블 로우 줄 지우기
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension DetailedUserInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let reuseIdentifier = "DetailedUserInfoCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailedUserInfoCell
            
            cell.configure(userInfo: userInfo)
            
            if isUserInfoCellExtended {
                
                cell.introduceLabel.numberOfLines = 0
                cell.readMoreLabel.textColor = .clear
                
            } else {
                
                cell.introduceLabel.numberOfLines = 3
                
                if let count = cell.introduceLabel.text?.characters.count, count <= 106 {
                    cell.readMoreLabel.textColor = .clear
                }
                
                tableView.estimatedRowHeight = 191.0
                tableView.rowHeight = UITableViewAutomaticDimension
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        default:
            
            let reuseIdentifier = "DetailedUserInfoCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailedUserInfoCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard !isUserInfoCellExtended else { return }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailedUserInfoCell else { return }
        
        cell.introduceLabel.numberOfLines = 0
        cell.readMoreLabel.textColor = .clear
        
        isUserInfoCellExtended = true
        
        tableView.beginUpdates()
        
        tableView.estimatedRowHeight = 191.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.endUpdates()

        
    }
}
