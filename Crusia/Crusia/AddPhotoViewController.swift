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
        //        나중에 수정하기 만들때 컬렉션뷰컨에 배열만들어서 배열에 어펜드 시키고 그 배열로 컬렉션뷰 뿌려준후 컬렉션 뷰마다 체크를 해서
        // 삭제 버튼을 눌렀을때 삭제하도록 한다
        
        
        
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
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var addPhotoBtnOut: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPhotoBtnOut.layer.cornerRadius = 3
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressView.progress = 0.3
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

