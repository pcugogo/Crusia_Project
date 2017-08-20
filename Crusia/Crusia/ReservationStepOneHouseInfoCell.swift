//
//  ReservationStepOneHouseInfoCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ReservationStepOneHouseInfoCell: UITableViewCell {

    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var houseTypeLabel: UILabel!
    @IBOutlet weak var houseImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureInformation()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 현재 예약 정보 불러오기
    func configureInformation() {
        
        self.hostNameLabel.text = "호스트: " + (ReservationService.shared.host?.firstName.stringValue)!
        
        let houseType = ReservationService.shared.house?.roomType.stringValue
        self.houseTypeLabel.text = TextChange.shared.enter(text: houseType!)
        
        if let url = ReservationService.shared.house?.houseImages[0]["image"].url {
            self.houseImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_bg"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
    }

}
