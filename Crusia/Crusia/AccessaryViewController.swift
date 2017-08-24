//
//  AccessaryViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 23..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import Kingfisher
import MessageUI
import Social
import Toaster

class AccessaryViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var house: House!
    var indexPath: IndexPath?
    var image: UIImageView?
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    enum MIMEType: String {
        case jpg = "image/jpeg"
        case png = "image/png"
        case doc = "application/msword"
        case ppt = "application/vnd.ms-powerpoint"
        case html = "text/html"
        case pdf = "application/pdf"
        
        init?(type: String) {
            switch type.lowercased() {
            case "jpg": self = .jpg
            case "png": self = .png
            case "doc": self = .doc
            case "ppt": self = .ppt
            case "html": self = .html
            case "pdf": self = .pdf
            default: return nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("하우스")
        print(house)
        
        configuteTableView()
        configureImage()
        
        // 블러 이펙트
        backgroundImageView.image = imageView.image
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureAccessaryView(house: House, indexPath: IndexPath) {
        
        self.house = house
        self.indexPath = indexPath
    }
    
    func configuteTableView() {

    }
    
    func configureImage() {
        if let url = house.houseImages[(indexPath?.row)!]["image"].url {
            
            self.imageView?.kf.setImage(with: url, placeholder: nil, options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
        
        titleLabel.text = house.title.stringValue
    }
    
    
}

extension AccessaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "AccessaryViewCell"
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccessaryViewCell
            cell.configureCell(title: "이메일", icon: #imageLiteral(resourceName: "hsemail"))
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccessaryViewCell
            cell.configureCell(title: "문자메시지", icon: #imageLiteral(resourceName: "hssms"))
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccessaryViewCell
            cell.configureCell(title: "페이스북", icon: #imageLiteral(resourceName: "hsfacebook"))
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccessaryViewCell
            cell.configureCell(title: "트위터", icon: #imageLiteral(resourceName: "hstwitter2"))
            cell.selectionStyle = .none
            return cell

            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccessaryViewCell
            cell.configureCell(title: "문자메시지", icon: #imageLiteral(resourceName: "hssms"))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedFile = filenames[indexPath.row]
//        let selectedFile = house.title.stringValue

        if indexPath.row == 2 {
            facebookShare()

        } else if indexPath.row == 3 {
            twitterShare()
        } else {
            let alertController = UIAlertController(title: nil, message: "개발중...", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)

        }
    }
}

extension AccessaryViewController: MFMessageComposeViewControllerDelegate {
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch(result) {
        case MessageComposeResult.cancelled:
            print("문자 메시지를 취소하였습니다.")
            
        case MessageComposeResult.failed:
            let alertMessage = UIAlertController(title: "Failure", message: "메세지를 보내는데 실패했습니다.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            
        case MessageComposeResult.sent:
            print("문자 메시지를 보냈습니다.")
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func sendSMS(attachment: String) {
        
        // 메시지 보낼 수 있는 상태인지 확인
        guard MFMessageComposeViewController.canSendText() else {
            let alertMessage = UIAlertController(title: "SMS 이용불가", message: "현재 SMS를 이용할 수 없습니다.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            return
        }
        
        // Prefill the SMS
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = self
        messageController.recipients = ["12345678", "72345524"]
        messageController.body = "Just sent the \(attachment) to your email. Please check!"
        
        // 파일 더하기
//        let fileparts = attachment.components(separatedBy: ".")
//        let filename = fileparts[0]
//        let fileExtension = fileparts[1]
//        let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension)
//        let fileUrl = NSURL.fileURL(withPath: filePath!)
        
        if let fileUrl = house.houseImages[0]["image"].url {
            print("url")
            print(fileUrl)
            
            messageController.addAttachmentURL(fileUrl, withAlternateFilename: nil)
        }
        
        // 메시지 뷰 컨트롤러 띄우기
        present(messageController, animated: true, completion: nil)
    }
    
    func twitterShare() {

        guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
            let alertMessage = UIAlertController(title: "트위터 이용불가", message: "등록된 트위터 계정이 없습니다.  Settings > Twitter 에서 페이스북 계정을 생성하세요.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
            return
        }
        
        // Display Tweet Composer
        if let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            tweetComposer.setInitialText("Crusia-" + self.house.title.stringValue)
            
            tweetComposer.add(self.imageView.image)
            self.present(tweetComposer, animated: true, completion: nil)
        }
    }
    
    func facebookShare() {
        // Check if Facebook is available. Otherwise, display an error message
        guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
            let alertMessage = UIAlertController(title: "Facebook 이용불가", message: "등록된 페이스북 계정이 없습니다. Settings > Facebook 에서 페이스북 계정을 생성하세요.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
            return
        }
        
        // Display Tweet Composer
        if let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
            fbComposer.setInitialText("Crusia-" + self.house.title.stringValue)
            fbComposer.add(self.imageView.image)
//            fbComposer.add(URL(string: ""))
            self.present(fbComposer, animated: true, completion: nil)
        }
    }

    
}

extension AccessaryViewController: MFMailComposeViewControllerDelegate {
    
    func showEmail(attachment: String) {
    }

}
















