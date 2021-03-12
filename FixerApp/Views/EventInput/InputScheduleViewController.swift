//
//  ViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 2/12/25.
//

import UIKit

class InputScheduleViewController: UIViewController {
    
    private var selectedStatus: TimeZoneStatus = .unavailable
    private var selectedDate: [Date] = []
    private var scheduleData: [[ TimeZoneStatus ]] = [[]]
    private var jsonString : String?
    
    @IBOutlet weak var timeZoneColectionView: UICollectionView! {
        didSet{
            timeZoneColectionView.delegate = self
            timeZoneColectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var buttonCircle: UIButton!
    @IBOutlet weak var buttonTriangle: UIButton!
    @IBOutlet weak var buttonCross: UIButton!
    @IBOutlet weak var buttonSend: UIButton!
    
    init(jsonString: String?) {
        self.jsonString =  jsonString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    
        buttonCircle.layer.cornerRadius = 30
        buttonTriangle.layer.cornerRadius = 30
        buttonCross.layer.cornerRadius = 30
        buttonSend.layer.cornerRadius = 10
        self.view.backgroundColor = .gray
        
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 30.0)
        layout.sectionInset = UIEdgeInsets(top:10, left:30, bottom:10, right: 30)
        layout.minimumInteritemSpacing = 1
        let size = UIScreen.main.bounds.size
        layout.itemSize = CGSize(width: (size.width - 70) / 8, height: 60)
        timeZoneColectionView.collectionViewLayout = layout
        
        timeZoneColectionView.register(UINib(nibName: "TimeZoneCell", bundle: nil), forCellWithReuseIdentifier: "timeZoneCell")
        timeZoneColectionView.register(UINib(nibName: "TimeZoneHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "timeZoneHeader")
    
        //テストで2月のデータを使用
        let calendar = Calendar(identifier: .gregorian)
  
        let date = calendar.date(from: DateComponents(year: 2021, month: 2, day: 1, hour: 0, minute: 0, second: 0))
        var dateComponents = calendar.dateComponents([.year,.month,.day,.hour, .minute, .second], from: date!)
        dateComponents.month = 2
        
        for day in 1...28 {
            dateComponents.day! = day
            selectedDate.append(calendar.date(from:dateComponents)!)
        }
        
        scheduleData = [[TimeZoneStatus]](repeating: [ TimeZoneStatus ](repeating: .unavailable, count: 8), count: selectedDate.count)
        scheduleDataInit()
    }
    
    @IBAction func buttonCircleTapped(_ sender: Any) {
        selectedStatus = .available
    }
    @IBAction func buttonTriangleTapped(_ sender: Any) {
        selectedStatus = .undecided
    }
    @IBAction func buttonCrossTapped(_ sender: Any) {
        selectedStatus = .unavailable
    }
    
    @IBAction func buttonSendtapped(_ sender: Any) {
        print("json: \n\n\(makeTimezoneJson())")
        present(didInputScheduleViewController(), animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func scheduleDataInit() {
        
        guard let jsonString = jsonString else {
            return
        }
            
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let timezones = try? decoder.decode([Timezone].self, from: jsonString.data(using: .utf8)!) else {
            print("error")
            return
        }
        
        //[Timezone]の数だけ繰り返し
        var index = 0
        for timezone in timezones {
          
            var i = 0
            //selectedDateから行番号を特定
            for date in selectedDate {
                if date.compare(timezone.date) == .orderedSame {
                    break
                }
                i += 1
            }
         
            //開始時間からの計算を行なってselectedDataの値を決定
            var j = timezones[index].from - 16 //16時からの調整なので定義しているが後々変更する
            while j < timezones[index].to - 16 {
                scheduleData[i][j] = timezones[index].timezoneStatus()
                j += 1
            }
            index += 1
        }
    }
    
    private func makeTimezoneJson() -> String {
        
        var timeZonesToMakeJson : [Timezone] = []
        
        for i in 0...scheduleData.count - 1 {
            var previousStatus = TimeZoneStatus.undefined
            var startRow = 0
            
            for j in 0...scheduleData[0].count {
                if(j == scheduleData[0].count) {
                    let timezone = Timezone(date: selectedDate[i], from: 16+startRow, to: 16+j, status: previousStatus.rawValue)
                    timeZonesToMakeJson.append(timezone)
                    break
                }
                
                let status = scheduleData[i][j]
                if(previousStatus == .undefined || previousStatus == status) {
                }
                else {
                    let timezone = Timezone(date: selectedDate[i], from: 16+startRow, to: 16+j, status: previousStatus.rawValue)
                    timeZonesToMakeJson.append(timezone)
                    startRow = j
                }
                previousStatus = status
            }
        }
        do {
            //WIP
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(timeZonesToMakeJson)
            let jsonString = String(data: data, encoding: .utf8)!
            return jsonString
        }
        catch let error {
            print(error)
            return ""
        }
    }
}

extension InputScheduleViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return selectedDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"

        if(kind == "UICollectionElementKindSectionHeader") {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "timeZoneHeader", for: indexPath) as! TimeZoneHeader
            
            DispatchQueue.main.async {
                header.backgroundColor = .gray
                header.dateLabel.text = df.string(from: self.selectedDate[indexPath.section])
            }
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = collectionView.cellForItem(at: indexPath) as? TimeZoneCell
        if let item = item {
            DispatchQueue.main.async {
                self.scheduleData[indexPath.section][indexPath.row] = self.selectedStatus
                item.contentView.backgroundColor = self.selectedStatus.color()
            }
        }
    }
}

extension InputScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let timezones = ["16〜17","〜18","〜19","〜20","〜21","〜22","〜23","〜24"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeZoneCell", for: indexPath) as! TimeZoneCell
        let timezoneStatus = scheduleData[indexPath.section][indexPath.row]
        
        DispatchQueue.main.async {
            cell.contentView.backgroundColor = timezoneStatus.color()
            cell.timezoneLabel.text = timezones[indexPath.row]
            cell.layer.cornerRadius = 5
        }
        return cell
    }
}

