//
//  ExplanationViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 11..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class ExplanationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var explanationTitle:String = ""
    var explanationContent:[String] = []
    
    @IBOutlet weak var titleLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLb.text = explanationTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return explanationContent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExplanationCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = explanationContent[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
