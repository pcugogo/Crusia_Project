//
//  UserInfoCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Kingfisher

class UserInfoCustomCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var houseTitleLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImageView.layer.cornerRadius = 30
        self.profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(post: House) {
        
        self.userNameLabel.text = post.host.firstName.string ?? ""
        self.houseTitleLabel.text = post.title.string ?? ""
        self.roomTypeLabel.text = post.roomType.string ?? ""
        
        if let url = post.host.imgProfile.url {
            self.profileImageView.kf.setImage(with: url)
        }
        
    }

}

