//
//  RoomsTypeCell.swift
//
//
//  Created by 샤인 on 2017. 8. 6..
//
//

import UIKit

class RoomsTypeCell: UITableViewCell {
    
    @IBOutlet weak var RoomsTypeLb: UILabel!
    
    @IBOutlet weak var RoomTypeCheckImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RoomTypeCheckImg.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
