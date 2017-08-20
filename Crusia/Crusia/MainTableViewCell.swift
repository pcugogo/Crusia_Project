//
//  MainTableViewCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 3..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var isHeartTouched: Bool!
    var isPostShown: Bool = false
    var indexPath: IndexPath!
    
    private var currentPost: House!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func heartTouched(_ sender: UIButton) {
        
//        if !isHeartTouched {
//            var isAleady: Bool = false
//            
//            for i in WishListService.shared.houses {
//                if i.pk == currentPost.pk {
//                    isAleady = true
//                }
//            }
//            
//            if !isAleady {
//                WishListService.shared.add(house: currentPost)
//            }
//            
//            heartButton.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
//            isHeartTouched = true
//            
//        } else {
//            
//            heartButton.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
//            WishListService.shared.delete(house: currentPost)
//            isHeartTouched = false
//            
//        }
//        
//
//        print("Heart Button touched ....................................")
//        for i in WishListService.shared.houses {
//            print(i.pk)
//        }
        
    }
    
    func configure(post: House) {
        
        // 현재 포스트 설정
        currentPost = post
        
        // cell style 설정
        self.selectionStyle = .none
        
        // 타이틀, 하우스타입, 가격 가져오기
        
        titleLabel.text = post.title.string
        typeLabel.text = TextChange.shared.enter(text: post.roomType.stringValue)
        
        // 가격에 , 찍기
        if let price = post.pricePerDay.int {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:price))
            
            priceLabel.text = "￦" + formattedNumber!
        }
        
        mainImageView.image = #imageLiteral(resourceName: "Flat")
//        if isPostShown == false {
//        
//            // Reset image view's image
//            mainImageView.image = nil
//            
//            isHeartTouched = false
//            heartButton.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
//        }
        
        // 이미지 설정
        if let url = post.houseImages[0]["image"].url {
            print("image ......................")
            print(url)
            print("post ........................")
            print(post)
//            self.mainImageView.kf.setImage(with: url)
            self.mainImageView.kf.setImage(with: url, placeholder: nil, options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
        
//        isHeartTouched = nil
//        
//        isHeartTouched = post.addedTowishList
        
        // 버튼 컬러 바꾸기
//        let origImage = UIImage(named: "heart2.png")
//        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        
        
//        if isHeartTouched {
//            heartButton.setImage(#imageLiteral(resourceName: "heart1"), for: .normal)
//
//        } else {
//            heartButton.setImage(#imageLiteral(resourceName: "heart2"), for: .normal)
//            heartButton.tintColor = .white
//
//        }
//        print("Configure post ................................................")
//        print(currentPost)

        // 포스트가 보여졌다고 표시
        isPostShown = true
    }


}
