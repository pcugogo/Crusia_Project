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
    
    @IBOutlet weak var explanationViewBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        explanationViewBtn.layer.cornerRadius = 20
        
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
        if identifier == "IntroduceViewSegue" {
            return true
        }else{
            if textView.text == "인테리어, 채광, 주변 정보 등에 대한 설명을 입력하세요" || textView.text.characters.count >= 501 {
                
                return false
            }else{
                return true
            }
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IntroduceViewSegue" {
            let explanationView = segue.destination as! ExplanationViewController
            explanationView.explanationTitle = "숙소의 매력이 무엇인가요?"
            explanationView.explanationContent.append("게스트는 회원님이 작성한 설명을 보고 숙소가 어떤 곳인지 파악하게 됩니다.")
            explanationView.explanationContent.append("회원님의 숙소가 다른 곳과 차별화되는 특징을 알려주세요. 발코니나 벽난로에 대해 설명하거나 숙소가 넓거나 아늑하다고 자랑하셔도 좋아요.")
            explanationView.explanationContent.append("회원님이 생각하는 숙소의 가장 큰 매력을 알려주면 게스트도 마음에 들어 할 거에요!")
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
