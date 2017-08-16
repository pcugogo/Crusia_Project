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
        HostingService.shared.bathRoomSaveAndBack = false
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
            cell.bathRoomCheckTextField.text = String(HostingService.shared.bathrooms)
        }else{
            cell.bathRoomCheckTextField.text = String(HostingService.shared.bathrooms)
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
        if HostingService.shared.oneStepComplete == true{
            navigationController?.popViewController(animated: true)
        }else if HostingService.shared.bathrooms == 0{
            HostingService.shared.bathrooms = 1
            navigationController?.popViewController(animated: true)
        }else if HostingService.shared.bathRoomSaveAndBack == true && HostingService.shared.bathrooms != 1 {
            backAlert()
        }else{

            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func backAlert() {
        let alert:UIAlertController = UIAlertController(title: "변경된 내용을 저장할까요?", message: "변경사항을 저장하지 않고 계속할 경우 변경사항이 적용되지 않습니다.", preferredStyle: .alert)
        let removeBtn:UIAlertAction = UIAlertAction(title: "삭제", style: .default) { (alert) in
            HostingService.shared.bathrooms = 1
            self.navigationController?.popViewController(animated: true)
            
        }
        let saveBtn:UIAlertAction = UIAlertAction(title: "저장", style: .default) { (alert) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(removeBtn)
        alert.addAction(saveBtn)
        self.present(alert, animated: true, completion: nil)
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
