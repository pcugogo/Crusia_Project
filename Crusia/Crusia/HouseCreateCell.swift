//
//  BasicsTableViewCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//



import UIKit

protocol HouseCreateViewCellDelegate {
    func nextBtn(indexPath:Int)
    
}

class HouseCreateCell: UITableViewCell {
    
    var delegate:HouseCreateViewCellDelegate?
    
    var topText:String?
    var detailText:String?
    var btnHidden:Bool?
    var cellIndexPath:Int?
    
    @IBOutlet weak var topTextLabel: UILabel!
    
    @IBOutlet weak var detailTextLb: UILabel!
    @IBOutlet weak var continueBtnOut: UIButton!
    @IBOutlet weak var checkImgView: UIImageView!
    
    @IBOutlet weak var secondStepBtnOut: UIButton!
    @IBOutlet weak var thirdStepBtnOut: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        continueBtnOut.layer.cornerRadius = 3
        secondStepBtnOut.layer.cornerRadius = 3
        thirdStepBtnOut.layer.cornerRadius = 3
        //        topTextLabel.text = topText 이렇게 하니깐 시점이 늦다
        //        detailTextLb.text = detailText
        //        continueBtnOut.isHidden = btnHidden ?? true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        delegate?.nextBtn(indexPath: cellIndexPath!)
        
    }
    
    
    
}
