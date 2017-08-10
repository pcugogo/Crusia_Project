//
//  HouseInfoCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class HouseInfoCustomCell: UITableViewCell {

    @IBOutlet weak var houseInfoLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(houseInfo: House) {
        
        if let text = houseInfo.introduce.string {
            self.houseInfoLabel.text = text
        }
    }
}
