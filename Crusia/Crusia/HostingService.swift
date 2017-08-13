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
    var introduce: String?
    var spaceInfo: String?
    var guestAccess: String?
    var pricePerDay: Int = 0
    var extraPeopleFee: Int = 0
    var cleaningFee: Int = 0
    var weeklyDiscount: Int = 0
    var accommodates: Int = 0
    var bathrooms: Int = 1
    var bedrooms: Int = 0
    var beds: Int = 1
    var roomType: String = "" //구현 할때 세그먼트같은것으로 생각해보자
    var houseImages: String? //필수인지 아닌지 헤깔린다
    var amenities: [String] = []
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var switchCheckNumber = 0
    var oneStepComplete = false
    
    func houseParameters() -> Parameters{
        let parameters: Parameters = ["title": title,
                                      "address":address,
                                      "introduce":introduce!,
                                      "space_info":spaceInfo!,
                                      "guest_access":guestAccess!,
                                      "price_per_day":pricePerDay,
                                      "extra_people_fee":extraPeopleFee,
                                      "cleaning_fee":cleaningFee,
                                      "weekly_discount":weeklyDiscount,
                                      "accommodates":accommodates,
                                      "bathrooms":bathrooms,
                                      "bedrooms":bedrooms,
                                      "beds":beds,
                                      "room_type":roomType,
                                      "house_images":houseImages ?? "",
                                      "amenities":amenities,
                                      "latitude":latitude,
                                      "longitude":longitude
        ]
        return parameters
    }

   
    
}
