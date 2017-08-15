//
//  PersonnePickCell.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 7..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit



class PersonnePickCell: UITableViewCell,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let numberPicker = UIPickerView()
    var pickerInputValue = [String]()
    var indexPath:Int?
    
    
    @IBOutlet weak var personneCheckLb: UILabel!
    @IBOutlet weak var personneTextField: UITextField!

  
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
      
        
        let toolBar = UIToolbar(frame:CGRect(x: 0,y: self.frame.size.height/6, width: self.frame.size.width, height: 50.0))
        
        toolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
  
        toolBar.tintColor = UIColor.black
        
        toolBar.backgroundColor = UIColor.white
        
        
        numberPicker.dataSource = self
        numberPicker.delegate = self
       
        
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PersonnePickCell.donePressed))
        
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil) // flexible space to add left end side
        
        toolBar.setItems([flexsibleSpace,doneButton], animated: true)
        
        
        personneTextField.inputAccessoryView = toolBar

        
        self.personneTextField.inputView = numberPicker
        

        
        
        
    }
    
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func donePressed(sender: UIBarButtonItem) {
        if indexPath == 0{
            HostingService.shared.accommodates = Int(personneTextField.text!)!
            HostingService.shared.personnelSaveAndBack = true
        }else{
            HostingService.shared.beds = Int(personneTextField.text!)!
            HostingService.shared.personnelSaveAndBack = true
        }
        print("======================",HostingService.shared.accommodates)
        print("======================",HostingService.shared.beds)
        personneTextField.resignFirstResponder()

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        
           return pickerInputValue.count
        
        
        
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

   
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.backgroundColor = .white
//        pickerView. = UIColor(red: 111, green: 183, blue: 199, alpha: 100)
        
        return pickerInputValue[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        personneTextField.text = pickerInputValue[row]
        
       
    }
    
    
    
    func configure(){
        
    }
    
}
