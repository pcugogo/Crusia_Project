//
//  EditUserInfoCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class EditUserInfoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    
    var tempUser: User?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String) {
        
        self.titleLabel.text = title
        
        contentTextField.placeholder = title + "을 입력하세요."
        
        var user: User = CurrentUserInfoService.shared.currentUser!
        
        switch title {
        case "유저네임":
            contentTextField.text = user.userName.stringValue
        case "이름":
            contentTextField.text = user.firstName.stringValue
        case "성":
            contentTextField.text = user.lastName.stringValue
        case "성별":
            contentTextField.text = user.gender.stringValue
            contentTextField.placeholder = "MALE/FEMALE/OTHER 중 입력"
        case "생일":
            contentTextField.text = user.birthday.stringValue
            contentTextField.placeholder = "Ex: 1990-01-01"
        case "연락처":
            contentTextField.text = user.phoneNum.stringValue
        case "자기소개":
            contentTextField.text = user.introduce.stringValue
        case "언어":
            contentTextField.text = user.prefLanguage.stringValue
        case "거주지":
            contentTextField.text = user.livingSite.stringValue
        default:
            break
        }

    }
    
    func editUser() {

        let title: String = self.titleLabel.text!

        
        switch title {
        case "유저네임":
            let userName: JSON = ["username": contentTextField.text!]
            
            CurrentUserInfoService.shared.tempUser?.userName = userName["username"]
            
        case "이름":
            let userName: JSON = ["first_name": contentTextField.text!]
            
            CurrentUserInfoService.shared.tempUser?.firstName = userName["first_name"]
            
        case "성":
            let lastName: JSON = ["last_name": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.lastName = lastName["last_name"]

        case "성별":
            let gender: JSON = ["gender": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.gender = gender["gender"]

        case "생일":
            let birthday: JSON = ["birthday": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.birthday = birthday["birthday"]

        case "연락처":
            let phoneNumber: JSON = ["phone_num": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.phoneNum = phoneNumber["phone_num"]

        case "자기소개":
            let introduce: JSON = ["introduce": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.introduce = introduce["introduce"]

        case "언어":
            let language: JSON = ["preference_language": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.prefLanguage = language["preference_language"]

        case "거주지":
            let site: JSON = ["living_site": contentTextField.text!]
            CurrentUserInfoService.shared.tempUser?.livingSite = site["living_site"]

        default:
            break
        }
    }

}

extension EditUserInfoCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        contentTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        contentTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        editUser()
    }
    
}













