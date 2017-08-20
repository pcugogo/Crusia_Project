//
//  AmenitiesViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 4..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import SwiftyJSON

class AmenitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var amenities: JSON?
    var postShown = [Bool]()
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureTableView() {
        // 안쓰는 테이블 로우 줄 지우기
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        postShown = [Bool](repeating: false, count: (amenities?.arrayValue.count)!)
    }
    
}

extension AmenitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = amenities?.array?.count {
            return count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "AmenitiesCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AmenitiesCustomCell
        
        cell.configure(data: (amenities?[indexPath.row])!)
        cell.selectionStyle = .none
        
        tableView.rowHeight = 80.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // fade in
//        // 처음 상태
//        cell.alpha = 0
//        
//        // 마지막 상태
//        UIView.animate(withDuration: 1.0) { 
//            cell.alpha = 1
//        }
        
        // rotating
        // 처음 상태
//        let rotationAngleInRadians = 90.0 * CGFloat(Double.pi/180.0)
        
        if postShown[indexPath.row] {
            return
        }
        
        postShown[indexPath.row] = true
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
//        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
        cell.layer.transform = rotationTransform
        
        // 마지막 상태
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
        
    }
}



















