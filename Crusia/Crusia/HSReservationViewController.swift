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
    @IBOutlet weak var checkInMonthLabel: UILabel!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutMonth: UILabel!
    @IBOutlet weak var checkOutDate: UILabel!
    
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.white
    let currentDateSelectedViewColor = UIColor.blue
    
    let todaysDate = Date()
    var eventsFromTheServer: [String: String] = [:]
    var firstDate: Date?
    var lastDate: Date?

    var currentHousePk: Int = 0
    
    let formatter = DateFormatter()
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let serverObjects = self.getServerEvents()
            
            for (date, event) in serverObjects {
                let stringDate = self.formatter.string(from: date)
                self.eventsFromTheServer[stringDate] = event
            }
            
            DispatchQueue.main.async {
                self.calendarView.reloadData()
            }
        }
        
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
        
        // range selection
        calendarView.allowsMultipleSelection = true
        calendarView.isRangeSelectionUsed = true
        
        calendarView.scrollToHeaderForDate(Date())
//        calendarView.scrollToDate(Date(), animateScroll: false)
        
//        firstDate = Date()
//        calendarView.selectDates([Date()])
        
        // Setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // Setup labels
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    
    // Cell Configure Functions
    func configureCell(cell: JTAppleCell?, cellState: CellState) {
        
        guard let myCustomCell = cell as? HSReservationViewCell else { return }
        formatter.dateFormat = "yyyy-MM-dd"
        
        handleCellTextColor(cell: myCustomCell, cellState: cellState)
        handleCellVisiblity(cell: myCustomCell, cellState: cellState)
        handleCellSelected(cell: myCustomCell, cellState: cellState)
        handleCellEvents(cell: myCustomCell, cellState: cellState)
        handleCellSelection(cell: myCustomCell, cellState: cellState)
    }
    
    
    func handleCellTextColor(cell: HSReservationViewCell, cellState: CellState) {
        
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        if todaysDateString == monthDateString {
            
            if cellState.isSelected {
                cell.dateLabel.textColor = selectedMonthColor
            } else {
                cell.dateLabel.textColor = UIColor(red: 240/255, green: 109/255, blue: 81/255, alpha: 1.0)
            }
            
        } else {
            cell.dateLabel.textColor = cellState.isSelected ? selectedMonthColor : monthColor
        }
    }
    
    func handleCellVisiblity(cell: HSReservationViewCell, cellState: CellState) {
        
        cell.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true
    }

    func handleCellSelected(cell: HSReservationViewCell, cellState: CellState) {
        
        if cell.isSelected {
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }
    
    func handleCellSelection(cell: HSReservationViewCell, cellState: CellState) {
        
        
        if cellState.selectedPosition() == .middle {
            cell.selectedView.layer.cornerRadius = 0
            
        }
//        switch cellState.selectedPosition() {
//        case .full, .left, .right:
//            cell.selectedView.isHidden = false
//            cell.selectedView.backgroundColor = UIColor.yellow // Or you can put what ever you like for your rounded corners, and your stand-alone selected cell
//        case .middle:
//            cell.selectedView.isHidden = false
//            cell.selectedView.backgroundColor = UIColor.blue // Or what ever you want for your dates that land in the middle
//        default:
//            cell.selectedView.isHidden = true
//            cell.selectedView.backgroundColor = nil // Have no selection when a cell is not selected
//        }
    }
    
    // MARK: - 이벤트 처리(예약불가 날짜 표시)
    func handleCellEvents(cell: HSReservationViewCell, cellState: CellState) {
        if eventsFromTheServer.contains(where: { $0.key == formatter.string(from: cellState.date)}) {
            cell.dateLabel.textColor = UIColor.lightGray
        }
        cell.unavailableLabel.isHidden = !eventsFromTheServer.contains { $0.key == formatter.string(from: cellState.date)}
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
    
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        
        guard let first = firstDate, let last = lastDate  else {
            return print("예약정보 불충분")
        }
        
        let firstDay = formatter.string(from: first)
        let lastDay = formatter.string(from: last)
        
        ReservationService.shared.makeRservation(housePk: currentHousePk, checkInDate: firstDay, checkOutDate: lastDay)
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
        
        configureCell(cell: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        configureCell(cell: cell, cellState: cellState)
        cell?.bounce()
        if firstDate != nil {
            lastDate = cellState.date
        
            checkOutMonth.textColor = UIColor.black
            
            print("마지막 날짜는 ......................")
//            print(lastDate)
            
            calendarView.selectDates(from: firstDate!, to: cellState.date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            
            checkOutMonth.text = monthFormatter.string(from: lastDate!) + "월"
            checkOutDate.text = dayFormatter.string(from: lastDate!) + "일"
            
        } else {
            firstDate = cellState.date
            print("첫번재 날짜는 ......................")
            
            print(formatter.string(from: firstDate!))
            checkInMonthLabel.textColor = UIColor.black
            checkOutMonth.textColor = UIColor(red: 111/255, green: 183/255, blue: 173/255, alpha: 1.0)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            
            checkInMonthLabel.text = monthFormatter.string(from: firstDate!) + "월"
            checkInDateLabel.text = dayFormatter.string(from: firstDate!) + "일"
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
        configureCell(cell: cell, cellState: cellState)
    }
    
    // scroll 하면 업데이트 한다. 연도와 시간을
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setupViewsOfCalendar(from: visibleDates)
    }
}

extension HSReservationViewController {
    
    func getServerEvents() -> [Date: String] {
        
        formatter.dateFormat = "yyyy MM dd"

        return [
            formatter.date(from: "2017 08 03")!: "Happy Birthday",
            formatter.date(from: "2017 08 04")!: "Happy Birthday",
            formatter.date(from: "2017 08 05")!: "Happy Birthday",
            formatter.date(from: "2017 08 06")!: "Happy Birthday",
            formatter.date(from: "2017 08 07")!: "Happy Birthday",
            formatter.date(from: "2017 08 08")!: "Happy Birthday",
            formatter.date(from: "2017 08 09")!: "Happy Birthday"
        ]
    }
}













