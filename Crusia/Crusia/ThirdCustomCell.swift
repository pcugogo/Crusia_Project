//
//  ThirdCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ThirdCustomCell: UITableViewCell {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var moreLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(post: House) {
        
        print("여기는 어매너티 ............")
        
        // png 아이콘 넣기
        if let first: String = post.amenities[0]["name"].string {
            self.firstImageView.image = UIImage(named: "\(first).png")
        }
        
        if let second: String = post.amenities[1]["name"].string {
            self.secondImageView.image = UIImage(named: "\(second).png")
        }
        
        if let third: String = post.amenities[2]["name"].string {
            self.thirdImageView.image = UIImage(named: "\(third).png")
        }
        
        if let fourth: String = post.amenities[3]["name"].string {
            self.fourthImageView.image = UIImage(named: "\(fourth).png")
        }
        
        // more lable 계산
        if let moreItems = post.amenities.array?.count {
            
            if moreItems > 4 {
                moreLable.textColor = UIColor(red: 111.0/255.0, green: 183.0/255.0, blue: 173.0/255.0, alpha: 1.0)
                moreLable.text = "+ \(moreItems - 4)"
            }
        }
    }

}
