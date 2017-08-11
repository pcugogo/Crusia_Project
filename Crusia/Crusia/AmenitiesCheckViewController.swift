//
//  AmenitiesCheckViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 10..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class AmenitiesCheckViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let amenitieTitleValues = ["생필품","무선인터넷","샴푸","옷걸이","TV","케이블 TV","난방","에어컨","아침식사,커피,차 제공","실내 벽난로","헤어드라이어","숙소에 반려동물이 있음","도어맨","휠체어 접근가능"]
    let parameterName = ["Essentials","Wireless_Internet","Shampoo","Hangers","TV","Cable_TV","Heating","Air_conditioning","Breakfast","Indoor_fireplace","Dryer","Pets_allowed","Doorman","Wheelchair_accessible"]
    
    let amenitieContentValues = ["수건, 침대시트, 비누, 휴지","숙소 내에서 끊김없이 연결","중앙 난방 또는 숙소 내 개별 난방","특정 요구사항이 있는지 현지 법규를 확인해보세요"]
    var detailCellData:[String] = []
    var basicCellData:[String] = []
    
    @IBOutlet weak var registrationProgressView: UIProgressView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nextBtnOut: UIButton!
    
    @IBOutlet weak var detailExplanationBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtnOut.layer.cornerRadius = 3
        detailExplanationBtnOut.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registrationProgressView.setProgress(0.8, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        HouseData.shared.amenities += detailCellData
        //        HouseData.shared.amenities += basicCellData
        
        print(HostingService.shared.amenities)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenitieTitleValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let amenitiesDetailCell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesDetailCell", for: indexPath) as! AmenitiesDetailCell
            
            
            amenitiesDetailCell.AmeitiesTitleLb.text = amenitieTitleValues[indexPath.row]
            amenitiesDetailCell.parameterName = parameterName[indexPath.row]
            amenitiesDetailCell.AmeitiesContentLb.text = amenitieContentValues[0]
            
            return amenitiesDetailCell
            
        }else if indexPath.row == 1{
            let amenitiesDetailCell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesDetailCell", for: indexPath) as! AmenitiesDetailCell
            
            
            amenitiesDetailCell.AmeitiesTitleLb.text = amenitieTitleValues[indexPath.row]
            amenitiesDetailCell.parameterName = parameterName[indexPath.row]
            amenitiesDetailCell.AmeitiesContentLb.text = amenitieContentValues[1]
            
            return amenitiesDetailCell
            
        }else if indexPath.row == 6{
            let amenitiesDetailCell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesDetailCell", for: indexPath) as! AmenitiesDetailCell
            
            
            amenitiesDetailCell.AmeitiesTitleLb.text = amenitieTitleValues[indexPath.row]
            amenitiesDetailCell.parameterName = parameterName[indexPath.row]
            amenitiesDetailCell.AmeitiesContentLb.text = amenitieContentValues[2]
            
            return amenitiesDetailCell
            
        }else if indexPath.row == 13{
            let amenitiesDetailCell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesDetailCell", for: indexPath) as! AmenitiesDetailCell
            
            
            amenitiesDetailCell.AmeitiesTitleLb.text = amenitieTitleValues[indexPath.row]
            amenitiesDetailCell.parameterName = parameterName[indexPath.row]
            amenitiesDetailCell.AmeitiesContentLb.text = amenitieContentValues[3]
            
            return amenitiesDetailCell
            
        }else{
            
            let amenitiesBasicCell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesBasicCell", for: indexPath) as! AmenitiesBasicCell
            
            
            amenitiesBasicCell.AmenitiesLb.text = amenitieTitleValues[indexPath.row]
            amenitiesBasicCell.parameterName = parameterName[indexPath.row]
            
            return amenitiesBasicCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.row == 1 && indexPath.row == 6 && indexPath.row == 13{
            return 150
        }else{
            return 100
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "AmeniteiesViewExplanation" {
            let explanationView = segue.destination as! ExplanationViewController
            explanationView.explanationTitle = "어떤 편의시설을 제공해야 하나요?"
            explanationView.explanationContent.append("게스트 대부분은 침대 시트,수건,휴지 등\n필수 품목이 제공될 것이라 생각합니다.")
            explanationView.explanationContent.append("커피나 차 등의 부가 서비스가 필수는 아니\n지만 작은 배려로 게스트의 만족도를 높이면\n서 좋은 후기도 기대할 수 있습니다.")
        }
        
    }

    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        
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
