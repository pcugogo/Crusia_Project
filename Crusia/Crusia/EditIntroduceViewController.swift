//
//  EditIntroduceViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 13..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class EditIntroduceViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self
        contentTextView.text = CurrentUserInfoService.shared.tempUser?.introduce.stringValue

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 자기 소개 저장
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension EditIntroduceViewController: UITextViewDelegate {
    
    // 글자수 300까지 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count // for Swift use count(newText)
        return numberOfChars < 300;
    }
}
