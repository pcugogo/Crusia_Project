//
//  EditIntroduceCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 13..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class EditIntroduceCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var tempUser: User?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(title: String) {
        titleLabel.text = title
        contentLabel.text = CurrentUserInfoService.shared.tempUser?.introduce.stringValue

    }

}
