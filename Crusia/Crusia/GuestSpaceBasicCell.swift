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
    
    var parameterName:String?
    
    @IBOutlet weak var guestSpaceTitleLb: UILabel!
    
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
            HostingService.shared.amenities.removeLast()
        }
        print("=========detailCellData=========", HostingService.shared.amenities)
    }

}