//
//  ReservationStepOneCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ReservationStepOneCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var startDate: String = ""
    var endDate: String = ""
    let formatter = DateFormatter()


    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 셀 정보 불러오기
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.dateLabel.text = "예약 가능일 알아보기"
        
        if let checkInDate = ReservationService.shared.checkInDate, let checkOutDate = ReservationService.shared.checkOutDate{

            formatter.dateFormat = "M'월' dd'일'"
            self.startDate = formatter.string(from: checkInDate)
            formatter.dateFormat = "dd'일'"
            self.endDate = formatter.string(from: checkOutDate)
            
            self.dateLabel.text = startDate + "~" + endDate
        }
    }

}
