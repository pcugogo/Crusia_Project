//
//  EditUserViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Fusuma
class EditUserViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    let fusumaViewController = FusumaViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUser()
        

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 15.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = (endFrame?.size.height ?? 0.0) + 15
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 유저 세팅
    func configureUser() {
        
        // 유저 이름 가져오기
        let userName = CurrentUserInfoService.shared.tempUser?.firstName.stringValue
        self.userNameLabel.text = userName
        
        // 유저 이미지 가져오기
        if let imgUrl = CurrentUserInfoService.shared.tempUser?.imgProfile.url {
            self.profileImageView.kf.setImage(with: imgUrl)
        }
    }
    
    // 테이블뷰 세팅
    func configureTableView() {
        
        // 안쓰는 테이블 로우 줄 지우기
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
//        tableView.estimatedRowHeight = 120.0
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    
    @IBAction func imageChangeButtonTouched(_ sender: UIButton) {

        
        // Configure Fusuma
        fusumaViewController.hasVideo = false
        fusumaBackgroundColor = UIColor.white
        fusumaTintColor = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
        fusumaViewController.view.backgroundColor = UIColor.white
        fusumaViewController.delegate = self
        
        // Bring it up
        present(fusumaViewController, animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        CurrentUserInfoService.shared.edit()
        print("save 후 ........커렌트 유저 정보 ..................................................................")
        print(CurrentUserInfoService.shared.currentUser!)
        CurrentUserInfoService.shared.patchUserInfo()
        
        let alertController = UIAlertController(title: nil, message: "저장되었습니다.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okayAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension EditUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "유저ID"
            cell.configure(title: title)
            return cell

        case 1:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "이름"
            cell.configure(title: title)
            return cell

        case 2:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "성"
            cell.configure(title: title)
            return cell

        case 3:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "성별"
            cell.configure(title: title)
            return cell

        case 4:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "생일"
            cell.configure(title: title)
            return cell

        case 5:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "연락처"
            cell.configure(title: title)
            return cell

        case 6:
            tableView.estimatedRowHeight = 120.0
            tableView.rowHeight = UITableViewAutomaticDimension
            let reuseIdentifier = "EditIntroduceCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditIntroduceCell
            let title = "자기소개"
            cell.selectionStyle = .none
            cell.configure(title: title)
            return cell
            
        case 7:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "언어"
            cell.configure(title: title)
            return cell

        case 8:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "거주지"
            cell.configure(title: title)
            return cell

        default:
            let reuseIdentifier = "EditUserInfoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
            cell.selectionStyle = .none
            let title = "이름"
            cell.configure(title: title)
            return cell
        }
    }
    
    
    
}

extension EditUserViewController: FusumaDelegate {
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        
        // Resize the image
        let scaledImage = image.scale(newWidth: 100.0)
        
        guard let imageData = UIImageJPEGRepresentation(scaledImage, 0.3) else {
            return
        }
        
        profileImageView.image = image
        
        CurrentUserInfoService.shared.editUserProfileImage(imageData: imageData)
        
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        
        let alertController = UIAlertController(title: "Request Access", message: "We need to access your photo library for saving and retrieving your photos. Please choose Settings to grant us the access right.", preferredStyle: .alert)
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















