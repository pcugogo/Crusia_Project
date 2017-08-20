//
//  RSFourPriceCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class RSFourPriceCell: UITableViewCell {

    
    @IBOutlet weak var priceAndNightsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var couponButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell() {
        
        // 가격과 숙박일 정보
        guard let selectedDates = ReservationService.shared.selectedDates else { return }
        guard let house = ReservationService.shared.house  else { return }
        
        let price: String = String(house.pricePerDay.intValue)
        let subtotalPrice: String = String(house.pricePerDay.intValue * selectedDates)
        let tax: String = String(Int(Double(house.pricePerDay.intValue) * 0.1))
        
        self.priceAndNightsLabel.text = "￦" + price + " x " + "\(selectedDates)박"
        
        // 서브토탈 가격
        self.priceLabel.text = "￦" + subtotalPrice
        
        // 텍스 가격
        self.taxLabel.text = "￦" + tax
        
        // total
        if let subtotal = Int(subtotalPrice), let tax = Int(tax) {
            self.totalLabel.text = "￦" + String(subtotal + tax)
        }
    }

}
