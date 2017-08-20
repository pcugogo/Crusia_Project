//
//  CreateTitleViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 17..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class CreateTitleViewController: UIViewController,UITextViewDelegate {
    
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var characterLimitLb: UILabel!
    
    @IBOutlet weak var dismissBtnOut: UIButton!
    
    
    @IBOutlet weak var explanationViewBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explanationViewBtn.layer.cornerRadius = 20

        
        
        textView.delegate = self
        
        dismissBtnOut.layer.cornerRadius = 3
        if textView.text.isEmpty{
            dismissBtnOut.alpha = 0.7
        }
        
        if textView.text == "" {
            textViewDidEndEditing(textView)
        }
        
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDismiss)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        progressView.progress = 0.7
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dismissKeyboard(){
        textView.resignFirstResponder()
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = "제목 추가"
            textView.textColor = UIColor.lightGray
            dismissBtnOut.alpha = 0.7
        }else if textView.text.characters.count >= 51 {
            dismissBtnOut.alpha = 0.7
        }else {
            dismissBtnOut.alpha = 1.0
        }
        textView.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "제목 추가"{
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.textView.endEditing(true)
    }
    
    //    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { //50까지쓰고 텍스트 못쓰게됨
    //        if textView.text.characters.count <= 50{
    //
    //            return true
    //        }else{
    //
    //            return false
    //        }
    //
    //
    //    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count <= 50{
            characterLimitLb.textColor = UIColor.black
            characterLimitLb.text = String("\(50 - textView.text.characters.count)")
            dismissBtnOut.alpha = 1.0
        }else{
            
            characterLimitLb.textColor = UIColor.red
            characterLimitLb.text = String("-\(textView.text.characters.count - 50)")
            dismissBtnOut.alpha = 0.7
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateTitleViewSegue" {
            let explanationView = segue.destination as! ExplanationViewController
            explanationView.explanationTitle = "제목을 간략하게 검토해 보세요."
            explanationView.explanationContent.append("사람들은 에어비앤비 숙소를 검색할 때 제목은 대충 훑어 봅니다. 간략하되 숙소의 개성을 잘 표현하는 제목을 작성하세요. 근처에 무엇이 있는지, 숙소가 넓거나 아늑한지 또는 숙소의 특이사항을 알려주세요. 밝은 분위기, 가족용숙소, 매력적인 건물 등 어떤 스타일의 숙소인지 알려주는 것도 중요합니다.")
            
        }
        
    }
    
    @IBAction func dismissBtnAction(_ sender: UIButton) {
        if textView.text == "제목 추가" || textView.text.characters.count >= 51 || textView.text == "" || textView.text.isEmpty {
            if textView.text.characters.count >= 50{
                characterLimitLb.text = "50자 까지 가능합니다. -\(textView.text.characters.count - 50)"
            }else if textView.text == "제목 추가"{
                characterLimitLb.text = "제목을 입력해주세요."
            }
        }else{
            HostingService.shared.secondStepComplete = true
            HostingService.shared.title = textView.text!
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
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
