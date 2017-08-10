//
//  ExtraFeeCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class ExtraFeeCustomCell: UITableViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: [JSON], indePath: Int) {
        
        if indePath == 0 {
            
            self.subtitleLabel.text = "추가 인원"
            self.contentLabel.text = "1명 초과 시 1박당 ￦ \(data[indePath].intValue)"
            
        } else if indePath == 1 {
            
            self.subtitleLabel.text = "청소비"
            self.contentLabel.text = "￦ \(data[indePath].intValue)"
        } else {
            
            self.subtitleLabel.text = "주 단위 할인"
            self.contentLabel.text = "\(data[indePath].intValue) %"
        }

    }

}


