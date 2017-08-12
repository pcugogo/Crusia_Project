//
//  ProfileViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String) {
        
        self.titlelabel.text = title
        
        
        if title == "숙소등록" {
            self.iconImageView.image = #imageLiteral(resourceName: "addhome5")
        } else if title == "호스트 모드로 전환" {
            self.iconImageView.image = #imageLiteral(resourceName: "transfer2")
        } else if title == "서비스 약관" {
            self.iconImageView.image = #imageLiteral(resourceName: "terms2")
        } else {
            self.iconImageView.image = #imageLiteral(resourceName: "setting")
        }
    }

}
