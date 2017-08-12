//
//  EditUserInfoCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class EditUserInfoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    
    var delegate: EditUserInfoCellDelegate?
    
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
    

}

extension EditUserInfoCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        contentTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        contentTextField.resignFirstResponder()
        
        
        return true
    }
    
}

protocol EditUserInfoCellDelegate {
    
    func set(height: Double)
}











