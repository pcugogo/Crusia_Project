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
    let addPhotoViewController = AddPhotoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
         
        
//        HostingService.shared.houseCreateRequest()
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextBtnAction(_ sender: UIButton) {
        addPhotoViewController.houseCreateUpload()
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
