//
//  WhereViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

protocol WhereViewControllerDelegate {
    func nextBtnTouched()
    
    
}

class WhereViewController: UIViewController {
  
    var delegate:WhereViewControllerDelegate?
   
//    let mapViewContrllor = MapLocationViewController()
    
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var firstLineAddressTextField: UITextField!
    @IBOutlet weak var secondLineAddressTextField: UITextField!
    @IBOutlet weak var thirdLineAddressTextField: UITextField!
    @IBOutlet weak var postalNumberTextField: UITextField!
   
    @IBOutlet weak var detailExplanationBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailExplanationBtnOut.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "nextMapView" {
             let mapViewControllor:MapLocationViewController = segue.destination as! MapLocationViewController
            print(secondLineAddressTextField.text!)
            mapViewControllor.address = "\(self.secondLineAddressTextField.text!)"
            HostingService.shared.address = "\(countryTextField.text!) \(firstLineAddressTextField.text!) \(secondLineAddressTextField.text!) \(thirdLineAddressTextField.text!) 우편번호: \(postalNumberTextField.text!)"
            
            
            print("=========================================, \(HostingService.shared.address)")

        }else if segue.identifier == "WhereViewExplanation" {
            let explanationView = segue.destination as! ExplanationViewController
            explanationView.explanationTitle = "숙소의 주소는 예약이 확정된 게스트만 볼 수 있습니다."
            explanationView.explanationContent.append("예약이 확정되면 게스트가 회원님 숙소의 정확한 주소를 확인할 수 있습니다.")
            explanationView.explanationContent.append("다른 사람에게는 숙소의 대략적인 위치만 표시되어 어느 지역에 숙소가 있는지 확인할 수 있습니다.")
            
        }
        
        
    }
    
    

    
  
  

    @IBAction func backBtnItem(_ sender: UIBarButtonItem) {
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
