//
//  HouseCreateViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 3..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire



class HouseCreateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HouseCreateViewCellDelegate {
    
    var currentUser: User?
    
    var houseCreateCell = HouseCreateCell()
    
    @IBOutlet weak var hostingWelcomeLb: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var completeInformationBtnOut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  HostingService.shared.firstStepComplete == false || HostingService.shared.secondStepComplete == false || HostingService.shared.thirdStepComplete == false {
            completeInformationBtnOut.isHidden = true
        }
        
        completeInformationBtnOut.layer.cornerRadius = 2
        
        houseCreateCell.delegate = self
        
        //디드셀렉에서 뷰 식별해서 넘겨줘야됨
        
        currentUser = CurrentUserInfoService.shared.currentUser
        
        hostingWelcomeLb.text = (currentUser?.firstName.stringValue)! + "님 안녕하세요! 호스팅 준비를 시작하세요."
        
      
        self.currentUser = CurrentUserInfoService.shared.currentUser
        
        
        print(HostingService.shared.amenities)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if  HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true && HostingService.shared.thirdStepComplete == true {
            completeInformationBtnOut.isHidden = false
            print(HostingService.shared.houseParameters())
        }else{
            completeInformationBtnOut.isHidden = true
            print(HostingService.shared.houseParameters())
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HouseCreateCell = tableView.dequeueReusableCell(withIdentifier: "HouseCreateCell", for: indexPath) as! HouseCreateCell
        
        if indexPath.row == 0 {
            
            
            cell.topTextLabel.text = "기본 사항을 입력하세요"
            cell.detailTextLb.text = "침대, 욕실, 편의시설에 대한 정보를 작성하세요."
            cell.cellIndexPath = indexPath.row
            
            if HostingService.shared.firstStepComplete == true{
                cell.continueBtnOut.isHidden = true
                cell.checkImgView.isHidden = false
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = true
            }else{
                cell.continueBtnOut.isHidden = false
                cell.checkImgView.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = true

            }
            
            return cell
        }else if indexPath.row == 1 {
            
            cell.topTextLabel.text = "상세 정보를 제공해 주세요"
            cell.detailTextLb.text = "숙소가 잘 나온 사진을 올리고 게스트의 흥미를 끌 수 이쓴 설명을 작성하세요."
            cell.cellIndexPath = indexPath.row
            cell.checkImgView.isHidden = true
            
            if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == false{
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = false
                cell.thirdStepBtnOut.isHidden = true
                cell.topTextLabel.textColor = UIColor.black
                cell.detailTextLb.textColor = UIColor.black
            }else if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true{
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = true
                cell.checkImgView.isHidden = false
            }else{
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = true
                cell.topTextLabel.textColor = UIColor.lightGray
                cell.detailTextLb.textColor = UIColor.lightGray
            }
            
            return cell
        }else {
            
            cell.checkImgView.isHidden = true
            cell.topTextLabel.text = "게스트를 맞이할 준비를 하세요."
            cell.detailTextLb.text = "요금,달력,예약 조건을 설정하세요."
            cell.cellIndexPath = indexPath.row
            
            if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true && HostingService.shared.thirdStepComplete == false {
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = false
                cell.topTextLabel.textColor = UIColor.black
                cell.detailTextLb.textColor = UIColor.black
                
                
            }else if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true && HostingService.shared.thirdStepComplete == true{
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = true
                cell.topTextLabel.textColor = UIColor.black
                cell.detailTextLb.textColor = UIColor.black
                cell.checkImgView.isHidden = false
               
                
            }else{
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = true
                cell.topTextLabel.textColor = UIColor.lightGray
                cell.detailTextLb.textColor = UIColor.lightGray
                
            }
            
            return cell
        }
        
    }
    
    let cwStoryboard = UIStoryboard(name: "CW", bundle: nil)
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "FirstStep")
        let secondStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "SecondStep")
        let thirdStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "ThirdStep")
        
        if indexPath.row == 0{
            
            if HostingService.shared.firstStepComplete == true{
                present(firstStepNavi, animated: true, completion: nil)
            }
            
        }else if indexPath.row == 1{
            
            if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true {
                present(secondStepNavi, animated: true, completion: nil)
            }
            
            
        }else if indexPath.row == 2{
            
            if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true && HostingService.shared.thirdStepComplete == true {
                present(thirdStepNavi, animated: true, completion: nil)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    func nextBtn(indexPath: Int) {
        let firstStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "FirstStep")
        let secondStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "SecondStep")
        let thirdStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "ThirdStep")
        
        print("=======================indexPath===============",indexPath)
        
        if indexPath == 0 {
            present(firstStepNavi, animated: true, completion: nil)
        }else if indexPath == 1{
            present(secondStepNavi, animated: true, completion: nil)
        }else if indexPath == 2{
            present(thirdStepNavi, animated: true, completion: nil)
        }
    }
    
    
   
    @IBAction func completeInformationBtnAction(_ sender: UIButton) {
        
        print("==========================완료===========================",HostingService.shared.title)
        let alert:UIAlertController = UIAlertController(title: "작성을 완료하셨나요?", message: "완료를 누르시면 하우스가 등록됩니다", preferredStyle: .alert)
        
        let cancelBtn:UIAlertAction = UIAlertAction(title: "취소", style: .cancel) { (alert) in
            HostingService.shared.accommodates = 1
            HostingService.shared.beds = 1
            self.navigationController?.popViewController(animated: true)
            
        }
        
        let completeBtn:UIAlertAction = UIAlertAction(title: "완료", style: .default) { (alert) in
            HouseCreateUpload.standard.houseCreateUpload()
            
            HostingService.shared.firstStepComplete = false
            HostingService.shared.secondStepComplete = false
            HostingService.shared.thirdStepComplete = false
            
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelBtn)
        alert.addAction(completeBtn)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
