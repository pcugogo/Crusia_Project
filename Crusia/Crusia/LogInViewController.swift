//
//  LogInViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 2..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func logInButtonTouched(_ sender: UIButton) {
        
        // 예외처리: 모든 텍스트필드 비어있지 않아야함.
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
            
            let alertController = UIAlertController(title: "로그인 에러", message: "모든 텍스트필드를 입력하세요.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        // 로그인
        let parameters: Parameters = ["email": emailTextField.text!, "password": passwordTextField.text!]
        
        print("로그인")
        
        Alamofire.request("http://crusia.xyz/apis/user/login/", method: .post, parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let currentUserToken = json["token"].stringValue
                
                // UserDefaults 에 토큰 저장
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                UserDefaults.standard.set(true, forKey: "Authentification")
                
                print(UserDefaults.standard.object(forKey: "token") as! String)
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
                
                // Dismiss keyboard
                self.view.endEditing(true)
                
                // Present the main view
                
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarView") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error)
                
//                self.view.backgroundColor = .red
                
                let alertController = UIAlertController(title: "로그인 에러", message: "아이디와 비밀번호가 유효하지 않습니다.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        

    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func secureTextButtonTouched(_ sender: UIButton) {
        
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
}


extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        } else if passwordTextField.isFirstResponder{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (passwordTextField.text?.isEmpty)! {
            self.nextButton.alpha = 0.5
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if !(emailTextField.text?.isEmpty)! && passwordTextField.isEditing == true {
            
            
            self.nextButton.alpha = 1.0
        } else {
            self.nextButton.alpha = 0.5
        }
    }
    

    

}
















