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
   
    
    
    @IBOutlet weak var nextBtnOut: UIButton!
    @IBOutlet weak var detailExplanationBtnOut: UIButton!
   
    @IBOutlet weak var registrationProgressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtnOut.layer.cornerRadius = 3
        if HostingService.shared.roomType == "" {
            nextBtnOut.alpha = 0.7
        }else{
            nextBtnOut.alpha = 1.0
        }
        
        
        detailExplanationBtnOut.layer.cornerRadius = 25
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registrationProgressView.setProgress(0.1, animated: true)
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
            
        }else if identifier == "RoomTypeViewExplanation" {
            houseTypeCheck = true
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
                
                
                nextBtnOut.alpha = 1.0
                
                cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CheckImg")
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            }else{
                if HostingService.shared.oneStepComplete == true && HostingService.shared.roomType == "House" {
                    cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CheckImg")
                    
                }else{
                    
                    cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CircleImg-1")
                }
            }
            
            
        }else if indexPath.row == 1 {
            
            cell.RoomsTypeLb.text = "개인실"
            if secondCellBtnCheck == true {
                
                
                nextBtnOut.alpha = 1.0
                
               cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CheckImg")
                tableView.deselectRow(at: indexPath, animated: true)

                
            }else{
                
                if HostingService.shared.oneStepComplete == true && HostingService.shared.roomType == "Individual" {
                    cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CheckImg")
                    
                }else{
                    
                    cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CircleImg-1")
                }
                
                
            }
            
        }else if indexPath.row == 2 {
            
            cell.RoomsTypeLb.text = "다인실"
            if thirdCellBtnCheck == true {
                
                
                nextBtnOut.alpha = 1.0
                
                cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CheckImg")
                tableView.deselectRow(at: indexPath, animated: true)
                
            }else{
                
                if HostingService.shared.oneStepComplete == true && HostingService.shared.roomType == "Shared_Room" {
                    cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CheckImg")
                    
                }else{
                    
                    cell.RoomTypeCheckImg.image = #imageLiteral(resourceName: "CircleImg-1")
                }

               
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
    
    
//    let explanationView = ExplanationViewController()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "RoomTypeViewExplanation" {
            let explanationView = segue.destination as! ExplanationViewController
            explanationView.explanationTitle = "숙소 유형별 의미"
            explanationView.explanationContent.append("집전체\n게스트가 집 전체를 빌립니다. 별채도 가능합니다")
            explanationView.explanationContent.append("개인실\n게스트가 일부 공간을 공유하나 침실은 단독으로 사용합니다.")
            explanationView.explanationContent.append("다인실\n게스트가 단독으로 쓸 수 있는 방이 제공되지 않습니다.")
            
            
        }
            
    }



    @IBAction func dissmissBtnAction(_ sender: UIButton) {
        
        if HostingService.shared.oneStepComplete == true{
            dismiss(animated: true, completion: nil)
        }else{
            HostingService.shared.roomType.removeAll()
            dismiss(animated: true, completion: nil)
        }
        
            
        
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
