//
//  CarouselViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 22..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {
    
    @IBOutlet var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(imageURL: URL) {
        
        self.imageview.kf.setImage(with: imageURL)
    }
}
