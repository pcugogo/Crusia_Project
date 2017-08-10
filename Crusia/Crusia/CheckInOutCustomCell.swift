//
//  CheckInOutCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 7..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class CheckInOutCustomCell: UITableViewCell {

    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
