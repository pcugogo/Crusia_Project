//
//  ReservationStepThreeViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ReservationStepThreeViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hostImageView: UIImageView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInfo()
        tableView.delegate = self
        tableView.dataSource = self
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                self.keyboardHeightLayoutConstraint?.constant = 50.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = (endFrame?.size.height ?? 0.0) + 50
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }

    
    func configureInfo() {
        
        self.hostImageView.image = #imageLiteral(resourceName: "logo_bg")
        
        if let url = ReservationService.shared.host?.imgProfile.url {
            self.hostImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo_bg"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        guard let house = ReservationService.shared.house else { return }
        
        // 예약 날짜가 없을 경우
        let price: String = String(house.pricePerDay.intValue)
        self.priceLabel.text = "￦" + price
        self.dateLabel.text = "/1박"
        
        // 예약 날짜가 있을 경우
        if let selectedDates = ReservationService.shared.selectedDates {
            let price: String = String(house.pricePerDay.intValue * selectedDates)
            self.priceLabel.text = "￦" + price
            self.dateLabel.text = "\(selectedDates)박"
        }
    }
    
    
    // 네비게이션바 세팅
    func configureNavigationbar() {
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //        navigationController?.navigationBar.isHidden = false
        //        navigationController?.setNavigationBarHidden(false, animated: true)
        //        navigationController?.hidesBarsOnSwipe = true
        
        //        self.tabBarController?.tabBar.isHidden = true
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationStepThreeCell", for: indexPath) as! ReservationStepThreeCell
        
        cell.textView.delegate = self
        
        return cell
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text as NSString?
        let updatedText = currentText?.replacingCharacters(in: range, with: text)
        

        if (updatedText?.isEmpty)! {
            
            textView.text = "여기에 메시지를 작성하세요"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            

        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

