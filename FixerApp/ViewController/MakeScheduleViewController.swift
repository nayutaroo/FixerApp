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
        
        let result = makeEventJsonString()
        switch result {
        case .success(let jsonStr):
            print(jsonStr)
        case .failure(let error):
            print(error)
            showAlert(with: error)
            return
        }
        
        
        // -- Do --  APIサーバへPOST処理
        
        
        present(MadeScheduleViewController(), animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func makeEventJsonString() -> Result<String,Error> {
        
        guard let eventName = eventNameTextfField.text, eventName != "" else {
            return .failure(NSError(domain: "イベント名が未入力です", code: -1, userInfo: nil))
        }
        
        guard selectedDate.count > 0 else {
            return .failure(NSError(domain: "日程の選択をしてください", code: -1, userInfo: nil))
        }
        
        
        guard startTimeRow < endTimeRow else {
            return .failure(NSError(domain: "時間帯の設定が不適切です", code: -1, userInfo: nil))
        }
    
        guard let userID =  UserDefaults.standard.object(forKey: "userID") as? String,
              let userName = UserDefaults.standard.object(forKey: "userName") as? String,
              let userImageUrlString = UserDefaults.standard.object(forKey: "userImageUrl") as? String
        else {
            return .failure(NSError(domain: "ユーザーデータを取得できません", code: -1, userInfo: nil))
        }
        
        var timezones: [Timezone] = []
        for date in selectedDate {
            timezones.append(Timezone(date: date, from: startTimeRow, to: endTimeRow, status: 0))
        }
        
        let userImageURL = URL(string: userImageUrlString)
        let user = User(id: userID, name: userName, imageURL: userImageURL)
        let event = Event(id: 0, name: eventName, makerId: userID, enteredUsers: [], unenteredUsers: [user], timezones: timezones, deadline: deadlineDatePicker.date, possibleTimezones: [], isDecided: false, decidedTimezone: nil)
        
        do {
            //WIP
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(event)
            let jsonString = String(data: data, encoding: .utf8)!
            return .success(jsonString)
        }
        catch let error {
            return .failure(error)
        }
    }
    
    private func showAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
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
