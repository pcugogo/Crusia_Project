//
//  HostingFeeViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class HostingFeeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var prograssView: UIProgressView!
    
    @IBOutlet weak var nextBtnOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        prograssView.progress = 0.5
        nextBtnOut.layer.cornerRadius = 3
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let hostingFeeCell = tableView.dequeueReusableCell(withIdentifier: "HostingFeeCell", for: indexPath) as! HostingFeeCell
            
            hostingFeeCell.contentLb.text = "1박 요금"
            hostingFeeCell.indexPath = indexPath.row
            
            
            return hostingFeeCell
        }else if indexPath.row == 1{
            let hostingFeeCell = tableView.dequeueReusableCell(withIdentifier: "HostingFeeCell", for: indexPath) as! HostingFeeCell
            
            hostingFeeCell.contentLb.text = "추가 인원 1명당 요금"
            hostingFeeCell.indexPath = indexPath.row
            hostingFeeCell.feeTextField.text = "0"
            
            return hostingFeeCell
            
        }else{
            let hostingFeeCell = tableView.dequeueReusableCell(withIdentifier: "HostingFeeCell", for: indexPath) as! HostingFeeCell
            
            hostingFeeCell.contentLb.text = "청소 비용"
            hostingFeeCell.indexPath = indexPath.row
            hostingFeeCell.feeTextField.text = "0"
            
            return hostingFeeCell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnItemAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
