//
//  AmenitiesDetailCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class AmenitiesDetailCell: UITableViewCell {
    
    
    
    
    
    var parameterName:String?
    
    
    @IBOutlet weak var AmeitiesTitleLb: UILabel!
    @IBOutlet weak var AmeitiesContentLb: UILabel!
    @IBOutlet weak var checkSwitchOut: UISwitch!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func checkSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true{
            if let parameter = parameterName {
                
                HostingService.shared.amenities.append(parameter)
                
            }
        }else{
            
            if let parameter = parameterName {
                
                HostingService.shared.remove(item: parameter)
                
            }
            
            
            
        }
        print("=========detailCellData=========", HostingService.shared.amenities)
    }
    
    
    
    
}
