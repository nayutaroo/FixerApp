//
//  HomeViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/25.
//

import UIKit

 //(How) セルの管理にジェネリクスを採用しようとするとUITableViewDelegateの継承を受けられなくなる。
 //genericを使用するためdelegateはVCの中に指定（delegateするとエラーを吐く）
 //(Bug) tableViewが表示されない。
final class HomeViewController : UIViewController {
 
    @IBOutlet weak var schedulesTableView: UITableView! {
        didSet{
            schedulesTableView.delegate = self
            schedulesTableView.dataSource = self
    
            switch eventStatus {
            case .unentered:
                schedulesTableView.register(unenteredEventsTableViewCell.nib, forCellReuseIdentifier: unenteredEventsTableViewCell.identifier)
            case .entered:
                //全員が入力いていない場合はunenteredを使う。
                schedulesTableView.register(unenteredEventsTableViewCell.nib, forCellReuseIdentifier: unenteredEventsTableViewCell.identifier)
                //全員が入力した場合はenteredを使って候補日の表示。
                schedulesTableView.register(enteredEventsTableViewCell.nib, forCellReuseIdentifier: enteredEventsTableViewCell.identifier)
            case .confirmed:
                schedulesTableView.register(confirmedEventsTableViewCell.nib, forCellReuseIdentifier: confirmedEventsTableViewCell.identifier)
            }
        }
    }
    
    
    private let jsonString: String?
    private let events: [Event]
    private let eventStatus: EventStatus
    
    init(events: [Event], status: EventStatus, jsonString: String?) {
        self.events = events
        self.jsonString = jsonString
        self.eventStatus = status
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(InputScheduleViewController(jsonString: jsonString), animated: true)
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch eventStatus {
        case .unentered:
            cell = tableView.dequeueReusableCell(withIdentifier: unenteredEventsTableViewCell.identifier)
                as! unenteredEventsTableViewCell
            (cell as! unenteredEventsTableViewCell).configure(event: events[indexPath.row])
    
        case .entered:
            if events[indexPath.row].unenteredUsers.count == 0 {
                //全員入力済みである場合は候補日の表示
                cell = tableView.dequeueReusableCell(withIdentifier: enteredEventsTableViewCell.identifier) as! enteredEventsTableViewCell
                (cell as! enteredEventsTableViewCell).configure(event: events[indexPath.row])
            }
            else {
                //全員のうち誰かが入力できていない場合は未入力状態と同じセルを用いる。
                cell = tableView.dequeueReusableCell(withIdentifier: unenteredEventsTableViewCell.identifier)
                    as! unenteredEventsTableViewCell
                (cell as! unenteredEventsTableViewCell).configure(event: events[indexPath.row])
            }
        case .confirmed:
            cell = tableView.dequeueReusableCell(withIdentifier: confirmedEventsTableViewCell.identifier) as! confirmedEventsTableViewCell
            (cell as! confirmedEventsTableViewCell).configure(event: events[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
