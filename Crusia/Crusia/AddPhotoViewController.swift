//
//  SecondStepViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Fusuma
import Alamofire
import SwiftyJSON

extension AddPhotoViewController: FusumaDelegate {
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
        print("fusumaMultipleImageSelected")
        for i in 0...images.count - 1{
            //            images[i].scale(newWidth: 100.0)
            
            
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
    @IBAction func dismissBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    let parameters: Parameters = HostingService.shared.houseParameters()
    
    func houseCreateUpload() {
        
        
        print(parameters)
        let httpHeader:HTTPHeaders = ["Authorization":"Token \(HostingService.shared.header)"]
        let url = "http://crusia.xyz/apis/house/"
        // 이미지 파일 수정
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let image = HostingService.shared.houseImages
            
            for key in self.parameters.keys{
                let name = String(key)
                if let val = self.parameters[name!] as? String{
                    print(val)
                    multipartFormData.append(val.data(using: .utf8)!, withName: name!)
                    
                }
            }
            for key in self.parameters.keys{
                let name = String(key)
                if let val = self.parameters[name!] as? Int{
                    print(val)
                    multipartFormData.append("\(val)".data(using: .utf8)!, withName: name!)
                    
                }
            }
            for key in self.parameters.keys{
                let name = String(key)
                if let val = self.parameters[name!] as? Double{
                    print(val)
                    multipartFormData.append("\(val)".data(using: .utf8)!, withName: name!)
                    
                }
            }
            
            
            
            
            
            if image.count == 1{
                multipartFormData.append(image[0], withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            }else if image.count == 2{
                multipartFormData.append(image[0], withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(image[1], withName: "image1", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            }else if image.count == 3{
                multipartFormData.append(image[0], withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(image[1], withName: "image1", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(image[2], withName: "image2", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            }
            
            
        }, usingThreshold:UInt64.init(),
           to: url, //URL Here
            method: .post,
            headers: httpHeader,
            encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    print("success ......................................................")
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("something")
                    })
                    
                    upload.responseJSON { response in
                        print("the resopnse code is : \(String(describing: response.response?.statusCode))")
                        print("the response is : \(response)")
                    }
                    break
                case .failure(let encodingError):
                    print("the error is  : \(encodingError.localizedDescription)")
                    break
                }
        })
        
        
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
