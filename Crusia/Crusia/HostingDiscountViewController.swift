//
//  HostingDiscountViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class HostingDiscountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let fee = HostingService.shared.pricePerDay
    let weeklyDiscount = HostingService.shared.weeklyDiscount
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(HostingService.shared.pricePerDay)
        print(HostingService.shared.extraPeopleFee)
        print(HostingService.shared.cleaningFee)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PercentCell", for: indexPath) as! PercentCell
        
        cell.fee = fee
        cell.weeklyDiscount = weeklyDiscount
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "PercentCell", for: indexPath) as! PercentCell
    //        cell.textFieldDidBeginEditing(cell.percentTextField)
    //
    //
    //    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func backBtnAction(_ sender: UIBarButtonItem) {
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
