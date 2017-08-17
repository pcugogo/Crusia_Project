//
//  WelcomeViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 2..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var facebookLogInBtn: UIButton!
    @IBOutlet weak var emailLogInBtn: UIButton!
    var dict : [String : AnyObject]!
    var facebookToken: FBSDKAccessToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLogInBtn.layer.cornerRadius = 45 / 2
        emailLogInBtn.layer.cornerRadius = 45 / 2
        emailLogInBtn.layer.borderWidth = 1.0
        emailLogInBtn.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

//        getUserInfoForTest()
//        getHouseInfoForTest()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func unwindtoWelcomeView(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func facebookLogInButtonTouched(_ sender: UIButton) {
        
        // 로그인시 버튼 작동 x
//        facebookLogInBtn.isEnabled = false
//        emailLogInBtn.isEnabled = false
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
//                        fbLoginManager.logOut()
                        self.facebookLogin()
                    }
                }
            }
        }

    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            print("Access Token ..........................")
            facebookToken = FBSDKAccessToken.current()
            
            if let token = facebookToken {
                print(token.tokenString)
            }
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }
    
    func facebookLogin() {
        
        print("페이스북 호출 함 수 .......안 쪽 ........................")
        guard let token = facebookToken else {
            return
        }
        
        // 로그인
        let parameters: Parameters = ["token": token.tokenString]
        
        print("로그인")
        
        Alamofire.request("http://crusia.xyz/apis/user/facebook-login/", method: .post, parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let currentUserToken = json["token"].stringValue
                let currentUserPk = json["user"]["pk"].numberValue
                
                // UserDefaults 에 토큰 저장
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                UserDefaults.standard.set(currentUserPk, forKey: "userPk")
                UserDefaults.standard.set(true, forKey: "Authentification")
                

                CurrentUserInfoService.shared.setCurrentUser()
                

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
        
        
//        // 페이스북 로그인 액션 끝나면 버튼 활성화
//        self.facebookLogInBtn.isEnabled = true
//        self.emailLogInBtn.isEnabled = true
    }
}

// Test: 유저 정보 하나 가져오기
func getUserInfoForTest() {
    
    Alamofire.request("http://crusia.xyz/apis/user/2", method: .get).validate().responseJSON { response in
 
        print("유저 정보 하나 가져오기 테스트 ......")
        
        switch response.result {
            
        case .success(let value):
            
            print("Validation Successful")
            
            let json = JSON(value)
            print("JSON: \(json)")
            
            let testUser: User = User(user: json)
            
            print(testUser)
            
        case .failure(let error):
            print(error)
   
        }
    }
}

//Test: 하우스 정보 하나 가져오기
func getHouseInfoForTest() {
    
    Alamofire.request("http://crusia.xyz/apis/house/1", method: .get).validate().responseJSON { response in
    
        print("하우스 정보 하나 가져오기 테스트 ......")
        
        switch response.result {
            
        case .success(let value):
            
            print("Validation Successful")
            
            let json = JSON(value)
            print("JSON: \(json)")
            
            let testHouse: House = House(house: json)
            
            print(testHouse)
            
        case .failure(let error):
            print(error)
            
        }
    }
    
    
}
