//
//  HostingDiscountViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class HostingDiscountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let fee = HostingService.shared.pricePerDay
    let weeklyDiscount = HostingService.shared.weeklyDiscount
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dismissBtnOut: UIButton!
    
    @IBOutlet weak var prograssView: UIProgressView!
   
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prograssView.progress = 0.7
        dismissBtnOut.layer.cornerRadius = 3
        print(HostingService.shared.pricePerDay)
        print(HostingService.shared.extraPeopleFee)
        print(HostingService.shared.cleaningFee)
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PercentCell", for: indexPath) as! PercentCell
        
        cell.fee = fee
        cell.weeklyDiscount = weeklyDiscount
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "PercentCell", for: indexPath) as! PercentCell
    //        cell.textFieldDidBeginEditing(cell.percentTextField)
    //
    //
    //    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismissBtnAction(_ sender: UIButton) {
        
        HostingService.shared.thirdStepComplete = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnAction(_ sender: UIBarButtonItem) {
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
