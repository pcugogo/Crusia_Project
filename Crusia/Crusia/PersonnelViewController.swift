//
//  PersonnelViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire

class PersonnelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var registrationProgressView: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtnOut.layer.cornerRadius = 3
        nextBtnOut.clipsToBounds = true
        
        HostingService.shared.personnelSaveAndBack = false
        print("================숙소 종류 데이터체크===================", HostingService.shared.roomType)
        
        HostingService.shared.title = "안녕하세요 테스트 " //2-3 숙소제목 (필)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registrationProgressView.setProgress(0.2, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let totalGuest = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    let totalBedRoom = ["1","2","3","4","5","6","7","8","9","10"]
    let totalBed = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","15"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonnePickCell", for: indexPath) as! PersonnePickCell
        
        
        if indexPath.row == 0 {
            if HostingService.shared.firstStepComplete == true {
                
                cell.personneTextField.text = String(HostingService.shared.accommodates)
            }else {
                cell.personneTextField.text = String(HostingService.shared.accommodates)
            }
            
            cell.personneCheckLb.text = "총 게스트 수"
            cell.pickerInputValue = totalGuest
            cell.indexPath = indexPath.row //커스텀에 인덱스를 넘겨줘서 이 인덱스로 어디에 들어갈 데이터인지 식별한다
            
            
        }else if indexPath.row == 1 {
            if HostingService.shared.firstStepComplete == true {
                cell.personneTextField.text = String(HostingService.shared.beds)
            }else {
                cell.personneTextField.text = String(HostingService.shared.beds)
            }
            
            cell.personneCheckLb.text = "게스트용 침실"
            cell.pickerInputValue = totalBedRoom
            cell.indexPath = indexPath.row
            
        }else{
            if HostingService.shared.firstStepComplete == true {
                cell.personneTextField.text = String(HostingService.shared.beds)
            }else {
                cell.personneTextField.text = String(HostingService.shared.beds)
            }
            
            cell.personneCheckLb.text = "게스트용 침대"
            cell.pickerInputValue = totalBed
            cell.indexPath = indexPath.row
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        print("================침대 갯수 데이터체크===================", HostingService.shared.beds)
    }
    
    @IBAction func backBtnItem(_ sender: UIBarButtonItem) {
        
        
        if HostingService.shared.firstStepComplete == true{
            navigationController?.popViewController(animated: true)
        }else if HostingService.shared.personnelSaveAndBack == true && HostingService.shared.accommodates != 1 && HostingService.shared.beds != 1 {
            backAlert()
        }else{
            
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    func backAlert() {
        let alert:UIAlertController = UIAlertController(title: "변경된 내용을 저장할까요?", message: "변경사항을 저장하지 않고 계속할 경우 변경사항이 적용되지 않습니다.", preferredStyle: .alert)
        let removeBtn:UIAlertAction = UIAlertAction(title: "삭제", style: .default) { (alert) in
            HostingService.shared.accommodates = 1
            HostingService.shared.beds = 1
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

