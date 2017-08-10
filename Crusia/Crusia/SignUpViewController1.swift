//
//  SignUpViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 3..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController1: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func registerButtonTouched(_ sender: UIButton) {
        
        // 예외처리: 모든 텍스트필드 비어있지 않아야함.
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "",
        let confirm = confirmTextField.text, confirm != "" else {
                
            let alertController = UIAlertController(title: "회원가입 에러", message: "모든 텍스트필드를 입력하세요.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // 예외처리: 암호 컨펌 맞는지 확인
        guard password == confirm else {
                
            let alertController = UIAlertController(title: "회원가입 에러", message: "암호를 다시 컨펌해주세요.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // 회원가입
        let parameters: Parameters = ["email": emailAddress, "password1": password, "password2": confirm]
        
        print("회원가입")
        
        Alamofire.request("http://crusia.xyz/apis/user/", method: .post, parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
                
                let alertController = UIAlertController(title: "회원가입 에러", message: "유효하지 않은 아이디.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        // 사인업 후 자동 로그인
        let loginParameters: Parameters = ["email": emailTextField.text!, "password": passwordTextField.text!]
        
        print("로그인")
        
        Alamofire.request("http://crusia.xyz/apis/user/login/", method: .post, parameters: loginParameters).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let currentUserToken = json["token"].stringValue
                
                // UserDefaults 에 토큰 저장
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                
                print(UserDefaults.standard.object(forKey: "token") as! String)
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        
        // Dismiss keyboard
        self.view.endEditing(true)
        
        // Present the main view
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
