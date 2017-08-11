//
//  HSReservationViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 11..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import  JTAppleCalendar

class HSReservationViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.white
    let currentDateSelectedViewColor = UIColor.blue
    
    
    
    let formatter = DateFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalenderView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupCalenderView() {
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? HSReservationViewCell else { return }

        if cellState.isSelected {
            
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }
    }

    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? HSReservationViewCell else { return }
        
        if validCell.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
}

extension HSReservationViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2017 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        
        return parameters
    }
}

extension HSReservationViewController: JTAppleCalendarViewDelegate {

    // Display the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "ReserveCell", for: indexPath) as! HSReservationViewCell
        
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
}













