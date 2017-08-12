//
//  EditUserViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUser()
        
        // Note that SO highlighting makes the new selector syntax (#selector()) look
        // like a comment but it isn't one
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
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
        let userName = CurrentUserInfoService.shared.currentUser?.firstName.stringValue
        self.userNameLabel.text = userName
        
        // 유저 이미지 가져오기
        if let imgUrl = CurrentUserInfoService.shared.currentUser?.imgProfile.url {
            self.profileImageView.kf.setImage(with: imgUrl)
        }
    }
    
    // 테이블뷰 세팅
    func configureTableView() {
        
        // 안쓰는 테이블 로우 줄 지우기
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        

        
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension EditUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "EditUserInfoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditUserInfoCell
        
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            let title = "이름"
            cell.configure(title: title)
        case 1:
            let title = "성"
            cell.configure(title: title)
        case 2:
            let title = "성별"
            cell.configure(title: title)
        case 3:
            let title = "생일"
            cell.configure(title: title)
        case 4:
            let title = "연락처"
            cell.configure(title: title)
        case 5:
            let title = "자기소개"
            cell.configure(title: title)
        case 6:
            let title = "언어"
            cell.configure(title: title)
        case 7:
            let title = "거주지"
            cell.configure(title: title)
        default:
            let title = "이름"
            cell.configure(title: title)
        }
        
        return cell
    }
    
}

extension EditUserViewController: EditUserInfoCellDelegate {
    
    func set(height: Double) {
//        self.tableView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: true)
//        tableView.reloadData()
    }
}
















