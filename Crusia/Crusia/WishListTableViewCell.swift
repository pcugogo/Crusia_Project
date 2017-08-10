//
//  WishListTableViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var isHeartTouched: Bool = false
    
    private var currentPost: House!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func heartTouched(_ sender: UIButton) {
        
        if isHeartTouched {
            
            WishListService.shared.delete(house: currentPost)
            isHeartTouched = false
            heartButton.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
            
        } else {
            
            WishListService.shared.add(house: currentPost)
            isHeartTouched = true
            heartButton.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
        }
        
        print("Heart Button touched ....................................")
        for i in WishListService.shared.houses {
            print(i.pk)
        }
        
    }
    
    func configure(post: House) {
        
        // 현재 포스트 설정
        currentPost = post
        
        // cell style 설정
        self.selectionStyle = .none
        
        // 타이틀, 하우스타입, 가격 가져오기
        
        titleLabel.text = post.title.string
        typeLabel.text = post.roomType.string
        
        if let price = post.pricePerDay.int {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:price))
            
            priceLabel.text = "￦" + formattedNumber!
        }
        
        // Reset image view's image
        mainImageView.image = nil
        
        if let url = post.houseImages[0]["image"].url {
            print("image ......................")
            print(url)
            print("post ........................")
            print(post)
            self.mainImageView.kf.setImage(with: url)
        }
        
        for i in WishListService.shared.houses {
            
            if i.pk == post.pk {
                isHeartTouched = true
            }
        }
    }

}
