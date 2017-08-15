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

class WhereViewController: UIViewController,UITextFieldDelegate {
  
    var delegate:WhereViewControllerDelegate?
   
//    let mapViewContrllor = MapLocationViewController()
    
    @IBOutlet weak var registrationProgressView: UIProgressView!
    
    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var postalNumberLb: UILabel!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var firstLineAddressTextField: UITextField!
    
    
    @IBOutlet weak var secondLineAddressTextField: UITextField!
    
    
    @IBOutlet weak var thirdLineAddressTextField: UITextField!
    
    
    @IBOutlet weak var postalNumberTextField: UITextField!
    
   
    @IBOutlet weak var detailExplanationBtnOut: UIButton!
    
    @IBOutlet weak var nextBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.delegate = self
        firstLineAddressTextField.delegate = self
        secondLineAddressTextField.delegate = self
        thirdLineAddressTextField.delegate = self
        postalNumberTextField.delegate = self
        
//        if HostingService.shared.oneStepComplete == true{
            countryTextField.text = HostingService.shared.whereViewCountry
            firstLineAddressTextField.text = HostingService.shared.whereViewFirstLineAddress
            secondLineAddressTextField.text = HostingService.shared.whereViewSecondLineAddress
            thirdLineAddressTextField.text = HostingService.shared.whereViewThirdLineAddress
            postalNumberTextField.text = HostingService.shared.whereViewPostalNumber
//        }
        
        nextBtnOut.layer.cornerRadius = 3
        detailExplanationBtnOut.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        registrationProgressView.setProgress(0.5, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !(countryTextField.text?.isEmpty)! && !(firstLineAddressTextField.text?.isEmpty)! && !(secondLineAddressTextField.text?.isEmpty)! && !(thirdLineAddressTextField.text?.isEmpty)! && !(postalNumberTextField.text?.isEmpty)! {
            
            return true

        }else{
            
            let checkAlert:UIAlertController = UIAlertController(title: "오류", message: "모든 항목을 입력해주세요.", preferredStyle: .alert)
            let checkError:UIAlertAction = UIAlertAction(title: "네", style:UIAlertActionStyle.cancel, handler: nil)
            checkAlert.addAction(checkError)
            self.present(checkAlert, animated: true, completion:nil)

            
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "nextMapView" {
             let mapViewControllor:MapLocationViewController = segue.destination as! MapLocationViewController
            print(secondLineAddressTextField.text!)
            mapViewControllor.address = "\(self.secondLineAddressTextField.text!)"
            HostingService.shared.address = "\(countryTextField.text!) \(firstLineAddressTextField.text!) \(secondLineAddressTextField.text!) \(thirdLineAddressTextField.text!) 우편번호: \(postalNumberTextField.text!)"
            HostingService.shared.whereViewCountry = countryTextField.text!
            HostingService.shared.whereViewFirstLineAddress = firstLineAddressTextField.text!
            HostingService.shared.whereViewSecondLineAddress = secondLineAddressTextField.text!
            HostingService.shared.whereViewThirdLineAddress = thirdLineAddressTextField.text!
            HostingService.shared.whereViewPostalNumber = postalNumberTextField.text!
            print("=========================================, \(HostingService.shared.address)")

        }else if segue.identifier == "WhereViewExplanation" {
            let explanationView = segue.destination as! ExplanationViewController
            explanationView.explanationTitle = "숙소의 주소는 예약이 확정된 게스트만 볼 수 있습니다."
            explanationView.explanationContent.append("예약이 확정되면 게스트가 회원님 숙소의 정확한 주소를 확인할 수 있습니다.")
            explanationView.explanationContent.append("다른 사람에게는 숙소의 대략적인 위치만 표시되어 어느 지역에 숙소가 있는지 확인할 수 있습니다.")
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("ReturnTouched")
        
        textField.resignFirstResponder()
        
        return true
    }

  

    @IBAction func backBtnItem(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        
//        if HostingService.shared.oneStepComplete == true{
//            navigationController?.popViewController(animated: true)
//        }else{
//            HostingService.shared.address = ""
//            navigationController?.popViewController(animated: true)
//        }
       
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
