//
//  MakeScheduleViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/24.
//

import UIKit
import FSCalendar

class MakeScheduleViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    private var selectedDate: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = true
        
        makeButton.layer.cornerRadius = 10
        scrollView.isScrollEnabled = true
        
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "calendarCell")
        
        // Do any additional setup after loading the view.
 
    }
    @IBAction func makeButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(InputScheduleViewController(), animated: true)
    }
}

extension MakeScheduleViewController: FSCalendarDelegate{
    func calendar(_ calender: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //表示する形式をformatterで指定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        selectedDate.append(formatter.string(from: date))
        print(selectedDate)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //表示する形式をformatterで指定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let deselectedDate = formatter.string(from: date)
        selectedDate.removeAll(where: {$0 == deselectedDate})
        print(selectedDate)
    }
    
}

extension MakeScheduleViewController: FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "calendarCell", for: date, at: position)
        return cell
    }
}
