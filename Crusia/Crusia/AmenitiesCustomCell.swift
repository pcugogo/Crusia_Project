//
//  AmenitiesCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class AmenitiesCustomCell: UITableViewCell {

    @IBOutlet weak var amenityLabel: UILabel!
    @IBOutlet weak var amenityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: JSON) {
        
        self.amenityLabel.text = TextChange.shared.enter(text: data["name"].stringValue)
        
        if let imageName: String = data["name"].string {
            self.amenityImageView.image = UIImage(named: "\(imageName).png")
        }
    }

}
