//
//  HostingFeeCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class HostingFeeCell: UITableViewCell {
    
    var indexPath:Int?
    
    @IBOutlet weak var contentLb: UILabel!
    
    @IBOutlet weak var feeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let toolBar = UIToolbar(frame:CGRect(x: 0,y: self.frame.size.height/6, width: self.frame.size.width, height: 50.0))
        
        toolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        
        toolBar.tintColor = UIColor.black
        
        toolBar.backgroundColor = UIColor.white
        
        
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HostingFeeCell.donePressed))
        
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil) // flexible space to add left end side
        
        toolBar.setItems([flexsibleSpace,doneButton], animated: true)
        
        
        feeTextField.inputAccessoryView = toolBar
        
        
        
        
    }
    
    
    
    
    
    func donePressed(sender: UIBarButtonItem) {
        
        if indexPath == 0 && feeTextField.text != ""{
            HostingService.shared.pricePerDay = Int(feeTextField.text!)!
        }else if indexPath == 1 && feeTextField.text != ""{
            HostingService.shared.extraPeopleFee = Int(feeTextField.text!)!
        }else if indexPath == 2 && feeTextField.text != ""{
            HostingService.shared.cleaningFee = Int(feeTextField.text!)!
        }else if feeTextField.text == "" {
            HostingService.shared.pricePerDay = 25000
            HostingService.shared.extraPeopleFee = 0
            HostingService.shared.cleaningFee = 0
        }
        
        
        print("======================",HostingService.shared.pricePerDay)
        print("======================",HostingService.shared.extraPeopleFee)
        print("======================",HostingService.shared.cleaningFee)
        
        feeTextField.resignFirstResponder()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
