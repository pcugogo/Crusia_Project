//
//  FirstCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class FirstCustomCell: UITableViewCell {

    @IBOutlet weak var accommodatesLabel: UILabel!
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(post: House) {

        
        self.accommodatesLabel.text = "게스트 \(post.accommodates.intValue) 명"
        self.bedroomsLabel.text = "방 \(post.bedrooms.intValue) 개"
        self.bedsLabel.text = "침대 \(post.beds.intValue) 개"
        self.bathroomsLabel.text = "욕실 \(post.bathrooms.intValue) 개"
    }
    
}
