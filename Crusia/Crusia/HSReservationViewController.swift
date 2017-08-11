//
//  HSReservationViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 11..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import JTAppleCalendar

class HSReservationViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.white
    let currentDateSelectedViewColor = UIColor.blue
    
//    var year: String = ""
    
    
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
        
        calendarView.scrollToDate(Date(), animateScroll: false)
        
        // Setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // Setup labels
        calendarView.visibleDates { (visibleDates) in
            
            self.setupViewsOfCalendar(from: visibleDates)
            
        }
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
    
    func handleCellVisiblity(view: JTAppleCell?, cellState: CellState) {
        view?.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true
    }

    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? HSReservationViewCell else { return }
        
        if validCell.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "header", for: indexPath) as! HSCalendarHeader
        
        self.formatter.dateFormat = "MMM"
        header.monthLabel.text = formatter.string(from: range.start)
        
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        
//        let date = visibleDates.monthDates.first?.date
        
        
        self.formatter.dateFormat = "yyyy"
//        self.year = self.formatter.string(from: date!)
        
        self.formatter.dateFormat = "MMM"
//        self.yearAndMonth.text = self.formatter.string(from: date!)
        
        
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
        handleCellVisiblity(view: cell, cellState: cellState)
        
        return cell
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellVisiblity(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellVisiblity(view: cell, cellState: cellState)
    }
    
    // scroll 하면 업데이트 한다. 연도와 시간을
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setupViewsOfCalendar(from: visibleDates)
        
    }
    
    
}













