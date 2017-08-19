//
//  IntroduceViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 16..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class IntroduceViewController: UIViewController, UITextViewDelegate {
    
    let addPhotoViewController = AddPhotoViewController()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var characterLimitLb: UILabel!
    
    @IBOutlet weak var nextBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        
        
        nextBtnOut.layer.cornerRadius = 3
        if textView.text.isEmpty {
            nextBtnOut.alpha = 0.7
        }
        
        
        if textView.text == "" {
            textViewDidEndEditing(textView)
        }
        
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDismiss)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        progressView.progress = 0.5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if textView.text == "인테리어, 채광, 주변 정보 등에 대한 설명을 입력하세요" || textView.text.characters.count >= 501 {
            
            return false
        }else{
            return true
        }
    }
    
    func dismissKeyboard(){
        textView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""  {
            textView.text = "인테리어, 채광, 주변 정보 등에 대한 설명을 입력하세요"
            textView.textColor = UIColor.lightGray
            nextBtnOut.alpha = 0.7
        }else if textView.text.characters.count >= 501{
            nextBtnOut.alpha = 0.7
        }else{
            nextBtnOut.alpha = 1.0
        }
        textView.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "인테리어, 채광, 주변 정보 등에 대한 설명을 입력하세요"{
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.textView.endEditing(true)
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count <= 500{
            characterLimitLb.textColor = UIColor.black
            characterLimitLb.text = String("\(500 - textView.text.characters.count)")
            nextBtnOut.alpha = 1.0
        }else{
            
            characterLimitLb.textColor = UIColor.red
            characterLimitLb.text = String("-\(textView.text.characters.count - 500)")
            nextBtnOut.alpha = 0.7
        }
    }
    
    
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        HostingService.shared.introduce = textView.text
        
    }
    
    @IBAction func backBtnItemAction(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
