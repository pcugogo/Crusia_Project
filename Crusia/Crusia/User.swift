//
//  User.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 2..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    
    // MARK: - Properties
    
    var pk: JSON
    var userName: JSON
    var email: JSON
    var imgProfile: JSON
    var firstName: JSON
    var lastName: JSON
    var gender: JSON
    var phoneNum: JSON
    var birthday: JSON
    var prefLanguage: JSON
    var prefCurrency: JSON
    var livingSite: JSON
    var introduce: JSON
    var lastJoin: JSON
    var dateJoin: JSON
    
    var dic: [String: Any] {
        get {
            let tempDic: [String: Any] = ["username": userName.stringValue,
                                          "first_name": firstName.stringValue,
                                          "last_name": lastName.stringValue,
                                          "gender": gender.stringValue,
                                          "birthday": birthday.stringValue,
                                          "phone_num": phoneNum.stringValue,
                                          "introduce": introduce.stringValue,
                                          "preference_language": prefLanguage.stringValue,
                                          "living_site": livingSite.stringValue]
            return tempDic
        }
    }
    
    init(user: JSON ) {
        self.pk = user["pk"]
        self.userName = user["username"]
        self.email = user["email"]
        self.imgProfile = user["img_profile"]
        self.firstName = user["first_name"]
        self.lastName = user["last_name"]
        self.gender = user["gender"]
        self.phoneNum = user["phone_num"]
        self.birthday = user["birthday"]
        self.prefLanguage = user["preference_language"]
        self.prefCurrency = user["preference_currency"]
        self.livingSite = user["living_site"]
        self.introduce = user["introduce"]
        self.lastJoin = user["last_login"]
        self.dateJoin = user["date_joined"]
    }
}

//struct User {
//    
//    // MARK: - Properties
//    
//    var pk: Int?
//    var userName: String?
//    var email: String
//    var imgProfile: String?
//    var firstName: String?
//    var lastName: String?
//    var gender: String?
//    var phoneNum: String?
//    var birthday: String?
//    var prefLanguage: String?
//    var prefCurrency: String?
//    var livingSite: String?
//    var introduce: String?
//    var lastJoin: String?
//    var dateJoin: String?
//    
//    init(user: JSON ) {
//        self.pk = user["pk"].int
//        self.userName = user["username"].string
//        self.email = user["email"].string!
//        self.imgProfile = user["img_profile"].string
//        self.firstName = user["first_name"].string
//        self.lastName = user["last_name"].string
//        self.gender = user["gender"].string
//        self.phoneNum = user["phone_num"].string
//        self.birthday = user["birthday"].string
//        self.prefLanguage = user["preference_language"].string
//        self.prefCurrency = user["preference_currency"].string
//        self.livingSite = user["living_site"].string
//        self.introduce = user["introduce"].string
//        self.lastJoin = user["last_login"].string
//        self.dateJoin = user["date_joined"].string
//    }
//}
