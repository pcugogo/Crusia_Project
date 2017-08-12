//
//  LogOutViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 8..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("로그아웃 뷰 에 들어옴 ......................")
        print("CurrentUserToken: \(UserDefaults.standard.object(forKey: "token") as! String)")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOutButtonTouched(_ sender: UIButton) {
        
        CurrentUserInfoService.shared.logOutCurrentUser()
        
        UserDefaults.standard.set(false, forKey: "Authentification")

        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }


}
