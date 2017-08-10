//
//  SecondCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class SecondCustomCell: UITableViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(post: House) {
        
        self.subTitleLabel.text = "최소 1 박 *"
    }

}
