//
//  SignUpEmailViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 8..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpEmailViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var signUpdata: User!
    var proceed: Bool = false
//    var isLoading: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(signUpdata)
        
        emailTextfield.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        proceed = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popButtonTouched(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        
        // 이메일 유효성 체크
        guard isValidEmail(testStr: emailTextfield.text!) else {
            let alertController = UIAlertController(title: nil, message: "올바른 이메일 형식이 아닙니다. 다시 작성해주세요.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        let email: JSON = JSON(stringLiteral: emailTextfield.text!)
        
        signUpdata.email = email
    }
    
    
    func configure(userData: User) {
        signUpdata = userData
    }
    
    
    
    // Segue Controlls
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let destination = segue.destination as! SignUpPasswordViewController
        
        destination.configure(userData: signUpdata)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
//        isLoading = true
        
        emailCehck()
        
        return proceed
    }
    
    func emailCehck() {
        
        
        Alamofire.request("http://crusia.xyz/apis/user/", method: .get).validate().responseJSON { response in
            
            print("유저 정보 하나 가져오기 테스트 ......")
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                var proceed: Bool = true
                
                for (index,subJson):(String, JSON) in json {
                    
                    print(index)
                    let tempUser: User = User(user: subJson)
                    
                    if tempUser.email.string == self.emailTextfield.text! {
                        proceed = false
                    }
                }
                
                if proceed == false {
                    
                    let alertController = UIAlertController(title: "이메일 체크 에러", message: "이미 존재하는 이메일 입니다. \n이메일을 다시 확인해주세요.", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    
                    alertController.addAction(okayAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
                // self.procced의 default 값을 false로 하기 위해서 내부적으로 쓸 proceed를 생성해서 넘겨주었다.
                self.proceed = proceed
//                self.isLoading = false
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    // 이메일 유효성 검사
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}

extension SignUpEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextfield.resignFirstResponder()
        
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        nextButton.alpha = 1.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (emailTextfield.text?.isEmpty)! {
            self.nextButton.alpha = 0.5
        }
    }
    
}





