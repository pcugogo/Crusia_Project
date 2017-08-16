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

class IntroduceViewController: UIViewController {
    
let header = UserDefaults.standard.object(forKey: "token") as! String
    override func viewDidLoad() {
        super.viewDidLoad()
        
            print("tttttttttttttttttttttttttttttttttttttttttttttttttttttt",header)
            let parameters:Parameters = HostingService.shared.houseParameters()
            let httpHeader:HTTPHeaders = ["Authorization":"Token \(header)"]
            print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", httpHeader)
            Alamofire.request("http://crusia.xyz/apis/house/", method: .post, parameters: parameters,  headers: httpHeader).validate().responseJSON { response in
            switch response.result {
        
            case .success(let value):
        
            print("Validation Successful")
        
            
            case .failure(let error):
            print(error)
            
            }
            
            }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
