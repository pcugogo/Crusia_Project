//
//  CurrentUserInfoService.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentUserInfoService {
    
    static let shared: CurrentUserInfoService = CurrentUserInfoService()
    
    var currentUser: User?
    var tempUser: User?
    
    private init() {
    
        let userName: JSON = ["first_name": ""]
        tempUser = User.init(user: userName)
    }
    
    func setCurrentUser() {
        
        let currentUserPk = UserDefaults.standard.object(forKey: "userPk") as! Int
        
        Alamofire.request("http://crusia.xyz/apis/user/\(currentUserPk)", method: .get).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("GetCurrentUser: \(json)")
                
                self.currentUser = User.init(user: json)
                
                self.tempUser = self.currentUser
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    func patchUserInfo() {
        
        
//        let parameters: Parameters = ["email": emailAddress, "password1": password, "password2": confirm]
//        let parameters: Parameters = (CurrentUserInfoService.shared.currentUser?.dic)!
//        
//        let currentUserPk = UserDefaults.standard.object(forKey: "userPk") as! Int
//        
//        Alamofire.request("http://crusia.xyz/apis/user/\(currentUserPk)", method: .get).validate().responseJSON { response in
//            
//            switch response.result {
//                
//            case .success(let value):
//                
//                print("Validation Successful")
//                
//                let json = JSON(value)
//                print("GetCurrentUser: \(json)")
//                
//                self.currentUser = User.init(user: json)
//                
//            case .failure(let error):
//                print(error)
//                
//            }
//        }
    }
    
    func edit() {
        
        currentUser = tempUser
    }
    
//    func edit(user: User) {
//        
//        let userName: JSON = ["first_name": ""]
//        tempUser = User.init(user: userName)
//        
//        tempUser?.firstName = user.firstName
//        tempUser?.lastName = user.lastName
//        tempUser?.gender = user.gender
//        tempUser?.birthday = user.birthday
//        tempUser?.phoneNum = user.phoneNum
//        tempUser?.introduce = user.introduce
//        tempUser?.prefLanguage = user.prefLanguage
//        tempUser?.livingSite = user.livingSite
//    }
    
    func logOutCurrentUser() {
        self.currentUser = nil
    }

}
