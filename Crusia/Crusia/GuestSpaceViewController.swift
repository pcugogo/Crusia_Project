//
//  GuestSpaceViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GuestSpaceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    
        var parameters: Parameters = ["title":  HostingService.shared.title,
                                      "address":HostingService.shared.address,
                                      "introduce":HostingService.shared.introduce!,
                                      "space_info":HostingService.shared.spaceInfo!,
                                      "guest_access":HostingService.shared.guestAccess!,
                                      "price_per_day":HostingService.shared.pricePerDay,
                                      "extra_people_fee":HostingService.shared.extraPeopleFee,
                                      "cleaning_fee":HostingService.shared.cleaningFee,
                                      "weekly_discount":HostingService.shared.weeklyDiscount,
                                      "accommodates":HostingService.shared.accommodates,
                                      "bathrooms":HostingService.shared.bathrooms,
                                      "bedrooms":HostingService.shared.bedrooms,
                                      "beds":HostingService.shared.beds,
                                      "room_type":HostingService.shared.roomType,
                                      "house_images":HostingService.shared.houseImages ?? "",
                                      "amenities":HostingService.shared.amenities,
                                      "latitude":HostingService.shared.latitude,
                                      "longitude":HostingService.shared.longitude
        ]
    
        let header = UserDefaults.standard.object(forKey: "token") as! String
    
    
    
    
    
   
    
    let guestSpaceTitleValues = ["부엌","세탁기","건물 내 무료 주차","엘리베이터","수영장","GYM"]
    let parameterName = ["Kitchen","Washer","Free_parking","Pool","Elevator","Gym"]
    
    let guestSpaceContentValues = ["게스트가 요리를 할 수 있는 공간","건물 내, 유료 또는 무료 이용 가능","전용 수영장으로 게스트 사용 가능","건물 내 체육관 무료 이용"]
    var detailCellData:[String] = []
    var basicCellData:[String] = []

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        HostingService.shared.amenities += AmenitiesViewController.standard.detailCellData
//        HostingService.shared.amenities += AmenitiesViewController.standard.basicCellData
        
        print(HostingService.shared.houseParameters())
        
        
        
        print("tttttttttttttttttttttttttttttttttttttttttttttttttttttt",header)
        let parameters:Parameters = HostingService.shared.houseParameters()
        let httpHeader:HTTPHeaders = ["Authorization":"Token \(header)"]
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", httpHeader)
        Alamofire.request("http://crusia.xyz/apis/house/", method: .post, parameters: parameters,  headers: httpHeader).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                
            case .failure(let error):
                print(error)
                
            }
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestSpaceTitleValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let guestSpaceDetailCell = tableView.dequeueReusableCell(withIdentifier: "GuestSpaceDetailCell", for: indexPath) as! GuestSpaceDetailCell
            
            guestSpaceDetailCell.guestSpaceTitleLb.text = guestSpaceTitleValues[indexPath.row]
            guestSpaceDetailCell.parameterName = parameterName[indexPath.row]
            guestSpaceDetailCell.guestSpaceContentLb.text = guestSpaceContentValues[0]
            
            return guestSpaceDetailCell
            
        }else if indexPath.row == 1{
            let guestSpaceDetailCell = tableView.dequeueReusableCell(withIdentifier: "GuestSpaceDetailCell", for: indexPath) as! GuestSpaceDetailCell
            
            guestSpaceDetailCell.guestSpaceTitleLb.text = guestSpaceTitleValues[indexPath.row]
            guestSpaceDetailCell.parameterName = parameterName[indexPath.row]
            guestSpaceDetailCell.guestSpaceContentLb.text = guestSpaceContentValues[1]
            
            return guestSpaceDetailCell
            
        }else if indexPath.row == 4{
            let guestSpaceDetailCell = tableView.dequeueReusableCell(withIdentifier: "GuestSpaceDetailCell", for: indexPath) as! GuestSpaceDetailCell
            
            guestSpaceDetailCell.guestSpaceTitleLb.text = guestSpaceTitleValues[indexPath.row]
            guestSpaceDetailCell.parameterName = parameterName[indexPath.row]
            guestSpaceDetailCell.guestSpaceContentLb.text = guestSpaceContentValues[2]
            
            return guestSpaceDetailCell
            
        }else if indexPath.row == 5{
            let guestSpaceDetailCell = tableView.dequeueReusableCell(withIdentifier: "GuestSpaceDetailCell", for: indexPath) as! GuestSpaceDetailCell
            
            guestSpaceDetailCell.guestSpaceTitleLb.text = guestSpaceTitleValues[indexPath.row]
            guestSpaceDetailCell.parameterName = parameterName[indexPath.row]
            guestSpaceDetailCell.guestSpaceContentLb.text = guestSpaceContentValues[3]
            
            return guestSpaceDetailCell
            
        }else{
            
            let guestSpaceBasicCell = tableView.dequeueReusableCell(withIdentifier: "GuestSpaceBasicCell", for: indexPath) as! GuestSpaceBasicCell
            
            guestSpaceBasicCell.guestSpaceTitleLb.text = guestSpaceTitleValues[indexPath.row]
            guestSpaceBasicCell.parameterName = parameterName[indexPath.row]
            
            return guestSpaceBasicCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.row == 1 && indexPath.row == 6 && indexPath.row == 13{
            return 150
        }else{
            return 100
        }
    }
    
    @IBAction func toHouseCreateViewBtnAction(_ sender: UIButton) {
       
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnItem(_ sender: UIBarButtonItem) {
        detailCellData.removeAll()
        basicCellData.removeAll()
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
