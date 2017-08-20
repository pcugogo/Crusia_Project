//
//  AmenitiesDetailCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class AmenitiesDetailCell: UITableViewCell {
    
    var indexPath:Int?
    
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
       
        
            
            if indexPath == 0{
                HostingService.shared.amenitiesDic["Essentials"] = sender.isOn
                HostingService.shared.amenitiesUpdate()
            }else if indexPath == 1{
                HostingService.shared.amenitiesDic["Wireless_Internet"] = sender.isOn
                HostingService.shared.amenitiesUpdate()
            }else if indexPath == 6{
                HostingService.shared.amenitiesDic["Heating"] = sender.isOn
                HostingService.shared.amenitiesUpdate()
            }else if indexPath == 13{
                HostingService.shared.amenitiesDic["Wheelchair_accessible"] = sender.isOn
                HostingService.shared.amenitiesUpdate()
            }



    }
    
    
    
    
}
