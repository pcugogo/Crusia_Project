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


class HouseCreateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //        HouseData.shared.address = "" //숙소가 어디에 있나요? 44444 주소 (국가, 시/도,시/군/구,도로명 주소, 아파트 동호수,우편번호
        HostingService.shared.introduce = "안녕하세요" // 숙소 소개
        HostingService.shared.spaceInfo = "정원 있습니다" // 숙소 부연 설명
        HostingService.shared.guestAccess = "별거 다 있어요" // 2-2 숙소 내 비품 설명
        HostingService.shared.pricePerDay = 10000 // 1박 비용 (필)
        HostingService.shared.extraPeopleFee = 3 //숙박 가능 인원22222222 추가 인원에 대한 비용 (필)
        HostingService.shared.cleaningFee = 10000 // 청소비 (필)
        HostingService.shared.weeklyDiscount = 20 // 일주일이상 장기투숙시 할인율 (필)
        //        HouseData.shared.accommodates = 1 //222222222 기본 숙박 가능 인원수 (필)
        //        HouseData.shared.bathrooms = 3 //욕실 개수 333333화장실 개수 (필)
        HostingService.shared.bedrooms = 5 //22222222침실 개수 (필)
        //        HouseData.shared.beds = 5 //침대 개수 (필)
        //        HouseData.shared.roomType = "House"     //등록할 숙소 종류는 무엇인가요?11111111 House(집전체 빌려줄 공간)  Individual(개인실),Shared_Room(다인실) 3개중 하나 (필)
        HostingService.shared.houseImages = ""////2-1
        //        HouseData.shared.amenities = ["TV","Internet"] //게스트가 이용할 수 있는 편의시설6666666,게스트가 어떤 공간을 사용 할 수 있나요?777777777 (테이블에 스위치로 구현) 숙소 내 편의시설 및 이용안내 사항
//        HostingService.shared.latitude = 37.517584 //핀이 놓인 위치가 정확한 가요?5555555 위도 (필)
//        HostingService.shared.longitude = 127.018133 //5555555555경도 (필)
        
        
        print(HostingService.shared.amenities)
       

        
        // Do any additional setup after loading the view.
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
            cell.continueBtnOut.isHidden = false
            
            return cell
        }else if indexPath.row == 1 {
            
            cell.topTextLabel.text = "상세 정보를 제공해 주세요"
            cell.detailTextLb.text = "숙소가 잘 나온 사진을 올리고 게스트의 흥미를 끌 수 이쓴 설명을 작성하세요."
            cell.continueBtnOut.isHidden = true

            
            return cell
        }else {
           
            cell.topTextLabel.text = "게스트를 맞이할 준비를 하세요."
            cell.detailTextLb.text = "요금,달력,예약 조건을 설정하세요."
            cell.continueBtnOut.isHidden = true

            
            return cell
        }
        
    }

    let cwStoryboard = UIStoryboard(name: "CW", bundle: nil)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "FirstStep")
        let secondStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "SecondStep")
        let thirdStepNavi = cwStoryboard.instantiateViewController(withIdentifier: "ThirdStep")
       
        if indexPath.row == 0{
            
            present(firstStepNavi, animated: true, completion: nil)
        
        
        }else if indexPath.row == 1{
            present(secondStepNavi, animated: true, completion: nil)
        }else if indexPath.row == 2{
            present(thirdStepNavi, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
