//
//  PercentCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class PercentCell: UITableViewCell,UITextFieldDelegate {
    
    
    var fee = 0
    var weeklyDiscount = 0
    
    let hostingDiscount = HostingDiscountViewController()
    
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var percentTextField: UITextField!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        HostingService.shared.weeklyDiscount = 10
        
        percentTextField.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        
        contentLb.text = "\(HostingService.shared.weeklyDiscount) % 할인을 반영한 평균 주간 요금은 ￦\((HostingService.shared.pricePerDay * 7) - (HostingService.shared.pricePerDay * 7 / HostingService.shared.weeklyDiscount))"
        
        
        let toolBar = UIToolbar(frame:CGRect(x: 0,y: self.frame.size.height/6, width: self.frame.size.width, height: 50.0))
        
        toolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        
        toolBar.tintColor = UIColor.black
        
        toolBar.backgroundColor = UIColor.white
        
        
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PercentCell.donePressed))
        
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil) // flexible space to add left end side
        
        toolBar.setItems([flexsibleSpace,doneButton], animated: true)
        
        
        percentTextField.inputAccessoryView = toolBar
        
        
        
        
    }
    
    
    
    func donePressed(sender: UIBarButtonItem) {
        if percentTextField.text == "" || percentTextField.text == "0"{
            weeklyDiscount = 0
            HostingService.shared.weeklyDiscount = 0
            percentTextField.text = "0"
            contentLb.text = "\(weeklyDiscount) % 할인을 반영한 평균 주간 요금은 ￦\(fee * 7)"
            
        }else{
            contentLb.text = "\(weeklyDiscount) % 할인을 반영한 평균 주간 요금은 ￦\((fee * 7) - (fee * 7 / weeklyDiscount))"
            HostingService.shared.weeklyDiscount = Int(percentTextField.text!)!
        }
        print("======================",HostingService.shared.weeklyDiscount)
        
        percentTextField.resignFirstResponder()
        
    }
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func didChangeText(textField: UITextField) {
        
        
        if let percentText = Int(percentTextField.text!) {
            if percentText != 0  {
                
                
                
                if  percentText >= 100 {
                    percentTextField.text = "99"
                    weeklyDiscount = 99
                    HostingService.shared.weeklyDiscount = 99
                    contentLb.text = "\(weeklyDiscount) % 할인을 반영한 평균 주간 요금은 ￦\((fee * 7) - (fee * 7 / weeklyDiscount))"
                    
                    self.reloadInputViews()
                }else{
                    weeklyDiscount = percentText
                    HostingService.shared.weeklyDiscount = percentText
                    contentLb.text = "\(HostingService.shared.weeklyDiscount) % 할인을 반영한 평균 주간 요금은 ￦\((fee * 7) - (fee * 7 / weeklyDiscount))"
                    self.reloadInputViews()
                }
                
            }else{
                percentTextField.text = "0"
                weeklyDiscount = 0
                HostingService.shared.weeklyDiscount = 0
                contentLb.text = "\(weeklyDiscount) % 할인을 반영한 평균 주간 요금은 ￦\(fee * 7)"
                self.reloadInputViews()
            }
        }
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        
    //    }
}
