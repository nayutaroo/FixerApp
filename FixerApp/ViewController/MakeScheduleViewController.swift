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
    private var selectedDate: [Date] = []
    
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
        present(MadeScheduleViewController(), animated: true)
        makeEventJsonString()
        navigationController?.popViewController(animated: true)
    }
    
    private func makeEventJsonString(){
//        struct Event : Decodable {
//            let id: Int
//            let name: String
//            let makerId: String                     // LINEのID次第でIntかStringかが変わる
//            let enteredUsers: [User]
//            let unenteredUsers: [User]
//            let timezones: [Timezone]               // スケジュールの入力する日程（時間帯）の範囲
//            let deadline: Date                      // 〆切日
//            let possibleTimezones: [Timezone]       // 候補時間帯 16日 13時〜17時, 17日 18時〜19時
//            let isDecided: Bool                     // 確定されてるかどうか
//            let decidedTimezone: Timezone?          // 確定した時間帯
//        }

        name = 
        
    }
}

extension MakeScheduleViewController: FSCalendarDelegate{
    func calendar(_ calender: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate.append(date)
        print(selectedDate)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate.removeAll(where: {$0 == date})
        print(selectedDate)
    }
}

extension MakeScheduleViewController: FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "calendarCell", for: date, at: position)
        return cell
    }
}
