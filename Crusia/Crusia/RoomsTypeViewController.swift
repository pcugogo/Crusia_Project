//
//  RoomsTypeViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 6..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class RoomsTypeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var firstCellBtnCheck:Bool = false
    var secondCellBtnCheck:Bool = false
    var thirdCellBtnCheck:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
      
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var houseTypeCheck = true
        if identifier == "nextPersonnelView"{
           
            if HostingService.shared.roomType == ""{
                houseTypeCheck = false
               
            }else{
                houseTypeCheck = true
            }
            
        }
        return houseTypeCheck
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RoomsTypeCell = tableView.dequeueReusableCell(withIdentifier: "RoomsTypeCell", for: indexPath) as! RoomsTypeCell
        
        if indexPath.row == 0 {
            cell.RoomsTypeLb.text = "집 전체"
            if firstCellBtnCheck == true {
                
                cell.RoomTypeCheckImg.image = UIImage(named: "CheckImg")
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            }else{
               
                cell.RoomTypeCheckImg.image = UIImage(named: "CircleImg")
                
            }

            
        }else if indexPath.row == 1 {
            cell.RoomsTypeLb.text = "개인실"
            if secondCellBtnCheck == true {
                
               cell.RoomTypeCheckImg.image = UIImage(named: "CheckImg")
                tableView.deselectRow(at: indexPath, animated: true)
                
            }else{
                
                cell.RoomTypeCheckImg.image = UIImage(named: "CircleImg")
            
                
            }
            
        }else if indexPath.row == 2{
            cell.RoomsTypeLb.text = "다인실"
            if thirdCellBtnCheck == true {
                
                cell.RoomTypeCheckImg.image = UIImage(named: "CheckImg")
                tableView.deselectRow(at: indexPath, animated: true)
                
            }else{
                
                 cell.RoomTypeCheckImg.image = UIImage(named: "CircleImg")
               
            }
        }
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:RoomsTypeCell = tableView.dequeueReusableCell(withIdentifier: "RoomsTypeCell", for: indexPath) as! RoomsTypeCell
        
        //House(집 전체 임대)/Individual(개인실)/Shared_Room(다인실)
        if indexPath.row == 0 {
            cell.RoomsTypeLb.text = "집 전체"
            firstCellBtnCheck = true
            secondCellBtnCheck = false
            thirdCellBtnCheck = false
            
            HostingService.shared.roomType = "House"
            
            tableView.reloadData()
            
        }else if indexPath.row == 1 {
            cell.RoomsTypeLb.text = "개인실"
            
            firstCellBtnCheck = false
            secondCellBtnCheck = true
            thirdCellBtnCheck = false
            
            tableView.reloadData()

            HostingService.shared.roomType = "Individual"
            
        }else if indexPath.row == 2{
            
            cell.RoomsTypeLb.text = "다인실"
            
            firstCellBtnCheck = false
            secondCellBtnCheck = false
            thirdCellBtnCheck = true
            
            HostingService.shared.roomType = "Shared_Room"
            
            tableView.reloadData()
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @IBAction func dissmissBtnAction(_ sender: UIButton) {
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
