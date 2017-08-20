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
    
    let houseCreateUpload = HouseCreateUpload()
    
    var currentUser: User?
    
    var houseCreateCell = HouseCreateCell()
    
    @IBOutlet weak var hostingWelcomeLb: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var completeInformationBtnOut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        houseCreateCell.delegate = self
        
        //디드셀렉에서 뷰 식별해서 넘겨줘야됨
        
        currentUser = CurrentUserInfoService.shared.currentUser
        
        hostingWelcomeLb.text = (currentUser?.firstName.stringValue)! + "님 안녕하세요! 호스팅 준비를 시작하세요."
        
        //                print("!!!!!!!!!!!!!!!!!!!!!!!!",currentUserData)
        //        print("@@@@@@@@@@@@@@@@@@@@@@@@@@",CurrentUserInfoService.shared.currentUser)
        //        hostingWelcomeLb.text = "\(String(describing: currentUserData?.firstName.stringValue))님 안녕하세요! 호스팅 준비를 시작하세요."
        //        HostingService.shared.title = "안녕하세요 테스트"
        //        HouseData.shared.address = "" //숙소가 어디에 있나요? 44444 주소 (국가, 시/도,시/군/구,도로명 주소, 아파트 동호수,우편번호
        //        HostingService.shared.introduce = "안녕하세요" // 숙소 소개
        //        HostingService.shared.spaceInfo = "정원 있습니다" // 숙소 부연 설명
        //        HostingService.shared.guestAccess = "별거 다 있어요" // 2-2 숙소 내 비품 설명
        //        HostingService.shared.pricePerDay = 10000 // 1박 비용 (필)
        //        HostingService.shared.extraPeopleFee = 3 //숙박 가능 인원22222222 추가 인원에 대한 비용 (필)
        //        HostingService.shared.cleaningFee = 10000 // 청소비 (필)
        //        HostingService.shared.weeklyDiscount = 20 // 일주일이상 장기투숙시 할인율 (필)
        //        HouseData.shared.accommodates = 1 //222222222 기본 숙박 가능 인원수 (필)
        //        HouseData.shared.bathrooms = 3 //욕실 개수 333333화장실 개수 (필)
        //        HostingService.shared.bedrooms = 5 //22222222침실 개수 (필)
        //        HouseData.shared.beds = 5 //침대 개수 (필)
        //        HouseData.shared.roomType = "House"     //등록할 숙소 종류는 무엇인가요?11111111 House(집전체 빌려줄 공간)  Individual(개인실),Shared_Room(다인실) 3개중 하나 (필)
        //        HostingService.shared.houseImages = ""////2-1
        //        HouseData.shared.amenities = ["TV","Internet"] //게스트가 이용할 수 있는 편의시설6666666,게스트가 어떤 공간을 사용 할 수 있나요?777777777 (테이블에 스위치로 구현) 숙소 내 편의시설 및 이용안내 사항
        //        HostingService.shared.latitude = 37.517584 //핀이 놓인 위치가 정확한 가요?5555555 위도 (필)
        //        HostingService.shared.longitude = 127.018133 //5555555555경도 (필)
        self.currentUser = CurrentUserInfoService.shared.currentUser
        
        
        print(HostingService.shared.amenities)
        
        
        //        hostingWelcomeLb.text = (currentUser?.firstName.stringValue)! + "님 안녕하세요."
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print(HostingService.shared.houseParameters())
        
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
            
            if HostingService.shared.firstStepComplete == true && HostingService.shared.secondStepComplete == true {
                cell.continueBtnOut.isHidden = true
                cell.secondStepBtnOut.isHidden = true
                cell.thirdStepBtnOut.isHidden = false
                cell.topTextLabel.textColor = UIColor.black
                cell.detailTextLb.textColor = UIColor.black
                
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
            
            if HostingService.shared.firstStepComplete == true{//추후에 여기서 &&로 투스텝도 만들어야된다 그리고 버튼 프리페어 처리해야된다
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
        let alert:UIAlertController = UIAlertController(title: "변경된 내용을 저장할까요?", message: "변경사항을 저장하지 않고 계속할 경우 변경사항이 적용되지 않습니다.", preferredStyle: .alert)
        
        let cancelBtn:UIAlertAction = UIAlertAction(title: "취소", style: .cancel) { (alert) in
            HostingService.shared.accommodates = 1
            HostingService.shared.beds = 1
            self.navigationController?.popViewController(animated: true)
            
        }
        
        let completeBtn:UIAlertAction = UIAlertAction(title: "완료", style: .default) { (alert) in
           self.houseCreateUpload.houseCreateUpload()
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelBtn)
        alert.addAction(completeBtn)
        

        
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
