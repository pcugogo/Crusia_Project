//
//  HSMessageViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HSMessageViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!

    @IBOutlet weak var messageStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageLoading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func messageLoading() {
        // 로딩 애니메이션
        loadingIndicator.type = .ballBeat
        loadingIndicator.color = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
        
        loadingIndicator.startAnimating()
        
        messageStatusLabel.text = "로딩중.."
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
                self.messageStatusLabel.text = "메시지를 모두 읽으셨습니다."
            }
        }
    }
    

}

extension HSMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = ""
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}
