//
//  ProfileViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 12..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUser()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 유저 세팅
    func configureUser() {
        
        // 유저 이름 가져오기
        let userName = CurrentUserInfoService.shared.currentUser?.userName.stringValue
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
        // 스크롤링 안되게 만들기
        tableView.isScrollEnabled = false
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileViewCell
        
        switch indexPath.row {
        case 0:
            let title = "숙소등록"
            cell.configure(title: title)
        case 1:
            let title = "호스트 모드로 전환"
            cell.configure(title: title)
        case 2:
            let title = "서비스 약관"
            cell.configure(title: title)
        case 3:
            let title = "로그아웃"
            cell.configure(title: title)
        default:
            let title = "숙소등록"
            cell.configure(title: title)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            showHostingView()
        case 3:
            logOut()
        default: break
            
        }
    }
    
    // 호스팅 뷰로 이동 (현재는 스토리 보드가 다르기 때문에, 코드 내용이 추후에 수정 되어야 함)
    func showHostingView() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CW", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        self.present(nextView!, animated: true, completion: nil)
    }
    
    // 로그아웃
    func logOut() {
        
        CurrentUserInfoService.shared.logOutCurrentUser()
        
        UserDefaults.standard.set(false, forKey: "Authentification")
        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }
}












