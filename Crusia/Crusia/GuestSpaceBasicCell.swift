//
//  GuestSpaceBasicCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class GuestSpaceBasicCell: UITableViewCell {
    
    let guestSpaceView:GuestSpaceViewController = GuestSpaceViewController()
    var indexPath:Int?
    var parameterName:String?
   
    @IBOutlet weak var guestSpaceTitleLb: UILabel!
    
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
            HostingService.shared.amenitiesDic["Free_parking"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }else if indexPath == 4{
            HostingService.shared.amenitiesDic["Elevator"] = sender.isOn
            HostingService.shared.amenitiesUpdate()
        }
    }
    
}
