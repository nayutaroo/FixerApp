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
    
    @IBOutlet weak var timeZoneColectionView: UICollectionView!{
        didSet{
            timeZoneColectionView.delegate = self
            timeZoneColectionView.dataSource = self
        }
    }
    @IBOutlet weak var buttonCircle: UIButton!
    @IBOutlet weak var buttonTriangle: UIButton!
    @IBOutlet weak var buttonCross: UIButton!
    @IBOutlet weak var buttonSend: UIButton!
    
    override func viewDidLoad() {
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
    
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: 2021, month: 1, day: 1))
        var dateComponents = calendar.dateComponents([.year,.month,.day], from: date!)
        dateComponents.month = 2
        
        for day in 1...28 {
            dateComponents.day! = day
            selectedDate.append(calendar.date(from:dateComponents)!)
        }
        
        scheduleData = [[TimeZoneStatus]](repeating: [ TimeZoneStatus ](repeating: .unavailable, count: 8), count: selectedDate.count)
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
        navigationController?.popViewController(animated: true)
    }
}

extension InputScheduleViewController: UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return selectedDate.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"

        if(kind == "UICollectionElementKindSectionHeader"){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "timeZoneHeader", for: indexPath) as! TimeZoneHeader
            header.backgroundColor = .gray
            header.dateLabel.text = df.string(from: selectedDate[indexPath.section])
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as! TimeZoneCell
        scheduleData[indexPath.section][indexPath.row] = selectedStatus
        item.contentView.backgroundColor = selectedStatus.color()
//       print(indexPath)
    }

    
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension InputScheduleViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let timezones = ["16〜17","〜18","〜19","〜20","〜21","〜22","〜23","〜24"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeZoneCell", for: indexPath) as! TimeZoneCell
        let timezoneStatus = scheduleData[indexPath.section][indexPath.row]
        cell.contentView.backgroundColor = timezoneStatus.color()
        cell.timezoneLabel.text = timezones[indexPath.row]
        cell.layer.cornerRadius = 5
        return cell
    }
}

