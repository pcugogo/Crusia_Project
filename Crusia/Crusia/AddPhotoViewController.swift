//
//  SecondStepViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Fusuma

extension AddPhotoViewController: FusumaDelegate {
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
       
        print("fusumaMultipleImageSelected")
        for i in 0...images.count - 1{
            images[i].scale(newWidth: 100.0)
            
            
            guard let imageData = UIImageJPEGRepresentation(images[i], 0.3) else {
                return
            }

            HostingService.shared.houseImages.append(imageData)
            
            print("============이미지 공간===========",HostingService.shared.houseImages)
        }
//
//        
        
        
//        CurrentUserInfoService.shared.editUserProfileImage(imageData: imageData)
    
    }
    
    
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
 
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        
        let alertController = UIAlertController(title: "사진 라이브러리 이용", message: "사진 라이브러리로 가도록 허용하시겠습니까?", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(settingAction)
        alertController.addAction(cancelAction)
        
        presentedViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
}

class AddPhotoViewController: UIViewController {

    let fusumaViewController = FusumaViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addPhotoBtnAction(_ sender: UIButton) {
        // Configure Fusuma
        fusumaViewController.allowMultipleSelection = true
        fusumaViewController.hasVideo = false
        fusumaBackgroundColor = UIColor.black
        fusumaTintColor = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        fusumaViewController.view.backgroundColor = UIColor.black
        fusumaViewController.delegate = self
        
        // Bring it up
        present(fusumaViewController, animated: true, completion: nil)
    
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
