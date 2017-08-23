//
//  AccessaryViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 23..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class AccessaryViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, icon: UIImage) {
        self.titleLabel.text = title
        self.iconImageView.image = icon
    }

}
