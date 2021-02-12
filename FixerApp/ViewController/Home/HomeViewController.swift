//
//  HomeViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
//    private let schedules : [ScheduleProtocol]
 
    @IBOutlet weak var schedulesTableView: UITableView!{
        didSet{
            schedulesTableView.delegate = self
            schedulesTableView.dataSource = self
            schedulesTableView.register(SchedulesTableViewCell.nib, forCellReuseIdentifier: SchedulesTableViewCell.identifier)
        }
    }
    
    private var jsonString: String?
    
    init(jsonString: String?){
        self.jsonString = jsonString
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(InputScheduleViewController(jsonString: jsonString), animated: true)
    }
}

extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SchedulesTableViewCell.identifier) as! SchedulesTableViewCell        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
