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
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mapViewContrllor:MapLocationViewController = segue.destination as! MapLocationViewController
        if segue.identifier == "nextMapView" {
            print(secondLineAddressTextField.text!)
            mapViewContrllor.address = "\(self.secondLineAddressTextField.text!)"
            HostingService.shared.address = "\(countryTextField.text!) \(firstLineAddressTextField.text!) \(secondLineAddressTextField.text!) \(thirdLineAddressTextField.text!) 우편번호: \(postalNumberTextField.text!)"
            
            
            print("=========================================, \(HostingService.shared.address)")

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
