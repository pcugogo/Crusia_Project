//
//  ThirdStepViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class GuestRequiredViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var nextBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtnOut.layer.cornerRadius = 0.3
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestRequiredBasicCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "모든 게스트는 다음과 같은 크루시아 필수 요건을 충족해야 합니다.\n\n •인증된 이메일 주소\n •인증된 전화번호\n •프로필 사진\n •결제정보\n •숙소 이용규칙에 동의\n •호스트에게 여행 목적 설명"
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 250
        }
        return 70
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
