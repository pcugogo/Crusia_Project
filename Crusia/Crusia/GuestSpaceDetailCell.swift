//
//  GuestSpaceDetailCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class GuestSpaceDetailCell: UITableViewCell {
    
    let guestSpaceView:GuestSpaceViewController = GuestSpaceViewController()
    var indexPath:Int?
    var parameterName:String?
    
    @IBOutlet weak var guestSpaceTitleLb: UILabel!
    @IBOutlet weak var guestSpaceContentLb: UILabel!
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
            HostingService.shared.amenitiesDic["Kitchen"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 1{
            HostingService.shared.amenitiesDic["Washer"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 3{
            HostingService.shared.amenitiesDic["Pool"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 5{
            HostingService.shared.amenitiesDic["Gym"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }
        
    }
    

    
}
