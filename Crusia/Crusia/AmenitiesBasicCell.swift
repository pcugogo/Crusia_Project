//
//  AmenitiesBasicCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class AmenitiesBasicCell: UITableViewCell {
    
    
    
    
    var parameterName:String?
    
    var indexPath:Int?
    
    @IBOutlet weak var AmenitiesLb: UILabel!
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
        if indexPath == 2{
            HostingService.shared.amenitiesDic["Shampoo"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 3{
            HostingService.shared.amenitiesDic["Hangers"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 4{
            HostingService.shared.amenitiesDic["TV"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 5{
            HostingService.shared.amenitiesDic["Cable_TV"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 7{
            HostingService.shared.amenitiesDic["Air_conditioning"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 8{
            HostingService.shared.amenitiesDic["Breakfast"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 9{
            HostingService.shared.amenitiesDic["Indoor_fireplace"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 10{
            HostingService.shared.amenitiesDic["Dryer"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 11{
            HostingService.shared.amenitiesDic["Pets_allowed"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 12{
            HostingService.shared.amenitiesDic["Doorman"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }
        
    }
    
    
    
    
    
}
