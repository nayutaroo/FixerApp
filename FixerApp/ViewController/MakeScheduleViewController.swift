//
//  MakeScheduleViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/24.
//

import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import LineSDK

class MakeScheduleViewController: UIViewController {
    
    @IBOutlet weak var eventNameTextfField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var timeZonePickerView: UIPickerView!{
        didSet{
            timeZonePickerView.dataSource = self
            timeZonePickerView.delegate = self
        }
    }
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    
    private var selectedDate: [Date] = []
    private var timeZoneItems: [Int] = ([Int])(0...24)
    private var startTimeRow: Int = 0
    private var endTimeRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = true
        
        makeButton.layer.cornerRadius = 10
        scrollView.isScrollEnabled = true
        
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "calendarCell")
        
    }
    
    @IBAction func makeButtonTapped(_ sender: Any) {
        
        startTimeRow = timeZonePickerView.selectedRow(inComponent: 0)
        endTimeRow = timeZonePickerView.selectedRow(inComponent: 1)
        
        guard startTimeRow < endTimeRow else {
            print("時間設定エラー")
            return
        }
        
        makeScheduleJsonString()
        
        // -- Do --  APIサーバへPOST処理
        
        
        present(MadeScheduleViewController(), animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func makeScheduleJsonString() {
        //[timezone]を作る
        
        var timezones: [Timezone] = []
        for date in selectedDate {
            timezones.append(Timezone(date: date, from: startTimeRow, to: endTimeRow, status: 0))
        }
        
        guard let userID =  UserDefaults.standard.object(forKey: "userID") as? String,
              let userName = UserDefaults.standard.object(forKey: "userName") as? String,
              let userImageUrlString = UserDefaults.standard.object(forKey: "userImageUrl") as? String
        else { return }
        
        let userImageURL = URL(string: userImageUrlString)
        
        let user = User(id: userID, name: userName, imageURL: userImageURL)
        guard let eventName = eventNameTextfField.text else { return }
        
        let event = Event(id: 0, name: eventName, makerId: userID, enteredUsers: [], unenteredUsers: [user], timezones: timezones, deadline: deadlineDatePicker.date, possibleTimezones: [], isDecided: false, decidedTimezone: nil)
        
        do {
            //WIP
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(event)
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
        }
        catch let error {
            print(error)
            return
        }
        
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
    }
}

extension MakeScheduleViewController: FSCalendarDelegate {
    func calendar(_ calender: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //表示する形式をformatterで指定
        selectedDate.append(date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //表示する形式をformatterで指定
        selectedDate.removeAll(where: {$0 == date})
    }
}

extension MakeScheduleViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "calendarCell", for: date, at: position)
        return cell
    }
}

extension MakeScheduleViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            return "\(timeZoneItems[row])時から"
        }
        else{
            return "\(timeZoneItems[row])時まで"
        }
    }
}

extension MakeScheduleViewController:
    UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeZoneItems.count
    }
}
