//
//  ReservationStepThreeCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ReservationStepThreeCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {

        textView.text = "여기에 메시지를 작성하세요"
        textView.textColor = UIColor.lightGray
        
        textView.becomeFirstResponder()
        
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    }

}

