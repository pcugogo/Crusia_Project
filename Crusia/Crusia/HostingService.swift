//
//  HouseData.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class HostingService {
    
    static var shared = HostingService()
    //토큰 넣어야된다
    
    var title: String = ""
    var address: String = ""
    var introduce: String = ""
    var spaceInfo: String = ""
    var guestAccess: String = ""
    var pricePerDay: Int = 25000
    var extraPeopleFee: Int = 0
    var cleaningFee: Int = 0
    var weeklyDiscount: Int = 10
    var accommodates: Int = 1
    var bathrooms: Int = 1
    var bedrooms: Int = 1
    var beds: Int = 1
    var roomType: String = "" //구현 할때 세그먼트같은것으로 생각해보자
    var houseImages:[Data] = [] //필수인지 아닌지 헤깔린다
    var amenities: [String] = []
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var switchCheckNumber = 0
    var firstStepComplete = false
    var secondStepComplete = false
    var thirdStepComplete = false
    
    var amenityString: String = ""
    
    
    var whereViewCountry = "대한민국"
    var whereViewFirstLineAddress = ""
    var whereViewSecondLineAddress = ""
    var whereViewThirdLineAddress = ""
    var whereViewPostalNumber = ""
    var personnelSaveAndBack = false
    var bathRoomSaveAndBack = false
    
    let amenitiesNameArr = ["Essentials","Wireless_Internet","Shampoo","Hangers","TV","Cable_TV","Heating","Air_conditioning","Breakfast","Indoor_fireplace","Dryer","Pets_allowed","Doorman","Wheelchair_accessible","Kitchen","Washer","Free_parking","Pool","Elevator","Gym"]
    
    
    var amenitiesDic:[String:Bool] = ["Essentials":false,"Wireless_Internet":false,"Shampoo":false,"Hangers":false,"TV":false,"Cable_TV":false,"Heating":false,"Air_conditioning":false,"Breakfast":false,"Indoor_fireplace":false,"Dryer":false,"Pets_allowed":false,"Doorman":false,"Wheelchair_accessible":false,"Kitchen":false,"Washer":false,"Free_parking":false,"Pool":false,"Elevator":false,"Gym":false]
    
    var amenitiesCheck:[String] = []
    
    func amenitiesUpdate(){
       
        for i in amenitiesNameArr{
            if amenitiesDic[i] == true{
                amenitiesCheck.append(i)
            }
        }
    }
    
    func amenitiesComplete(){
        
        for i in amenitiesNameArr{
            if amenitiesDic[i] == true{
                amenities.append(i)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    //서버 통신
    let header = UserDefaults.standard.object(forKey: "token") as! String
    
    func houseParameters() -> Parameters{
        
        
        
        let parameters: Parameters = ["title": title,
                                      "address":address,
                                      "introduce":introduce,
                                      "space_info":spaceInfo,
                                      "guest_access":guestAccess,
                                      "price_per_day":pricePerDay,
                                      "extra_people_fee":extraPeopleFee,
                                      "cleaning_fee":cleaningFee,
                                      "weekly_discount":weeklyDiscount,
                                      "accommodates":accommodates,
                                      "bathrooms":bathrooms,
                                      "bedrooms":bedrooms,
                                      "beds":beds,
                                      "room_type":roomType,
                                      //                                      "house_images":houseImages,
            "amenities":amenityString,
            "latitude":latitude,
            "longitude":longitude
        ]
        return parameters
    }
    
    
    
    //    func houseCreateRequest(){
    //        print("tttttttttttttttttttttttttttttttttttttttttttttttttttttt",header)
    //
    ////        HostingService.shared.amenity()
    //        print(HostingService.shared.amenityString)
    //
    //        let parameters:Parameters = HostingService.shared.houseParameters()
    //        let httpHeader:HTTPHeaders = ["Authorization":"Token \(header)"]
    //        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", httpHeader)
    //        Alamofire.request("http://crusia.xyz/apis/house/", method: .post, parameters: parameters,  headers: httpHeader).validate().responseJSON { response in
    //            switch response.result {
    //
    //            case .success(let value):
    //
    //                print("Validation Successful")
    //
    //
    //            case .failure(let error):
    //                print(error)
    //
    //            }
    //
    //        }
    //
    //    }
    
    func remove(item: String) {
        
        
        for i in 0...amenities.count - 1 {
            if item == amenities[i] {
                amenities.remove(at: i)
            }
        }
    }
    
    func amenity() {
        
        
        var amenity: String = ""
        
        
        
        if amenities.count > 1 {
            for i in amenities {
                if amenity == ""{
                    amenity = amenities[0]
                }else{
                    amenity = amenity + ", " + i
                }
            }
        }else if amenities.count != 0{
            
            amenity = amenities[0]
            
        }
        self.amenityString = amenity
        
        
    }
    
    
    
    
    
    
    
}
