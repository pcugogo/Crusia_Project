//
//  SignUpNameViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 8..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpNameViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var signUpData: User?
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func popButtonTouched(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        
        print("nextButtonTouched ...................")
        
        let userName: JSON = ["first_name": firstNameTextField.text!, "last_name": lastNameTextField.text!]

        signUpData = User(user: userName)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("preparefor segue .......................")
        let destination = segue.destination as! SignUpEmailViewController
        
        
        destination.configure(userData: signUpData!)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if !(firstNameTextField.text?.isEmpty)! && !(lastNameTextField.text?.isEmpty)! {
            return true
        }
        
        return false
    }

}


extension SignUpNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if firstNameTextField.isFirstResponder {
            lastNameTextField.becomeFirstResponder()
        } else if lastNameTextField.isFirstResponder{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (lastNameTextField.text?.isEmpty)! {
            self.nextButton.alpha = 0.5
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if !(firstNameTextField.text?.isEmpty)! && lastNameTextField.isEditing == true {
            
            
            self.nextButton.alpha = 1.0
        } else {
            self.nextButton.alpha = 0.5
        }
    }
}
