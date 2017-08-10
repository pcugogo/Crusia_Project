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

class WelcomeViewController: UIViewController {

    @IBOutlet weak var facebookLogInBtn: UIButton!
    @IBOutlet weak var emailLogInBtn: UIButton!
    
    
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
