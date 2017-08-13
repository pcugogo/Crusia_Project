//
//  bathroomViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BathRoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let totalBath = ["1","2","3","4","5","6","7","8"]
    
    @IBOutlet weak var registrationProgressView: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nextBtnOut: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtnOut.layer.cornerRadius = 3
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registrationProgressView.setProgress(0.3, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BathRoomCell", for: indexPath) as! BathRoomCell
        
        cell.pickerInputValue = totalBath
        
        if HostingService.shared.oneStepComplete == true {
            cell.bathRoomCheckTextField.text = String(HostingService.shared.accommodates)
        }
       
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        print("================욕실 갯수 데이터체크===================", HostingService.shared.bathrooms)
    }
    
    @IBAction func backBtnItem(_ sender: UIBarButtonItem) {
        HostingService.shared.bathrooms = 0
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
