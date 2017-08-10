//
//  DetailedUserInfoCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class DetailedUserInfoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var livingSiteLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImageView.layer.cornerRadius = 30
        self.profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(userInfo: User) {
        
        
        nameLabel.text = userInfo.firstName.stringValue
        livingSiteLabel.text = userInfo.livingSite.stringValue
        introduceLabel.text = userInfo.introduce.stringValue
        
        if let url = userInfo.imgProfile.url {
            profileImageView.kf.setImage(with: url)
        }
        
    }
    

}
