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
    
    var checkInDate: Date?
    var checkOutDate: Date?
    var selectedDates: Int?
    var message: String?
    var house: House?
    var host: User?
    
    private init() {}
    
    func clearReservationInfo() {
        self.checkInDate = nil
        self.checkOutDate = nil
        self.selectedDates = nil
        self.message = nil
        self.house = nil
        self.host = nil
    }
    
    func makeRservation(housePk pk: Int, checkInDate: String, checkOutDate: String) {
        
        let token: String = UserDefaults.standard.object(forKey: "token") as! String
        let httpHeader: HTTPHeaders = ["Authorization": "Token " + token]
        
        print("현재 유저 토큰 !! .................................................")
        print(token)
        
        let parameters: Parameters = ["checkin_date": checkInDate, "checkout_date": checkOutDate]
        print(checkInDate)
        print(checkOutDate)
        
        if let message = self.message {
    
            let parameters: Parameters = ["checkin_date": checkInDate, "checkout_date": checkOutDate, "message_to_host": message]
            
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
            
        } else {
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
    
    func checkDisableDatesOf(housePk pk: Int, completionHandler: @escaping (JSON) -> Void) {
        
        
        Alamofire.request("http://crusia.xyz/apis/house/\(pk)", method: .get).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                
                let unavailableDates = json["disable_days"]
                
                completionHandler(unavailableDates)

            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }

}


