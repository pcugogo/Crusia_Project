//
//  ReservationService.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 18..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ReservationService {
    
    static let shared: ReservationService = ReservationService()
    
    private init() {}
    
    func makeRservation(housePk pk: Int, checkInDate: String, checkOutDate: String) {
        
        let token: String = UserDefaults.standard.object(forKey: "token") as! String
        let httpHeader: HTTPHeaders = ["Authorization": "Token " + token]
        
        let parameters: Parameters = ["checkin_date": checkInDate, "checkout_date": checkOutDate]
        
        Alamofire.request("http://crusia.xyz/apis/reservations/?house=\(pk)", method: .post, parameters: parameters, headers: httpHeader).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("예약완료 .................................")
                print("예약정보가 다음과 같이 수정되었음!: \(json)")
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

}
