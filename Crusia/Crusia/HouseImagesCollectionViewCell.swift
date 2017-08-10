//
//  HouseImagesCollectionViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 7..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class HouseImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var houseImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(imageURL: URL) {
        
        self.houseImageview.kf.setImage(with: imageURL)
    }
}
