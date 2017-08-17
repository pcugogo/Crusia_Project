//
//  MainMapCollectionViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 16..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class MainMapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    var isLiked:Bool = false  {
        didSet {
            if isLiked {
                heartButton.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
            } else {
                heartButton.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
            }
        }
    }
    
    
    private var currentPost: House!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configure(post: House) {
        
        // 현재 포스트 설정
        currentPost = post
        titleLabel.text = post.title.string
        
        // 현재 셀 표시 숨기기
        lineView.isHidden = true
        
        // 가격에 , 찍기
        if let price = post.pricePerDay.int {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:price))
            
            priceLabel.text = "￦" + formattedNumber!
        }
        
        // 디폴트 이미지 설정
        houseImage.image = #imageLiteral(resourceName: "Flat")
        
        // 이미지 설정
        if let url = post.houseImages[0]["image"].url {
            print("image ......................")
            print(url)
            print("post ........................")
            print(post)
            //            self.mainImageView.kf.setImage(with: url)
            self.houseImage.kf.setImage(with: url, placeholder: nil, options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
    }
    
}
