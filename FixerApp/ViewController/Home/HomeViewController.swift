//
//  HomeViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/25.
//

import UIKit

final class HomeViewController: UIViewController {
//    @IBOutlet weak var makeScheduleButton: UIButton!
//    @IBOutlet weak var inputScheduleButton: UIButton!

    @IBOutlet weak var schedulesTableView: UITableView!{
        didSet{
            schedulesTableView.delegate = self
            schedulesTableView.dataSource = self
            schedulesTableView.register(SchedulesTableViewCell.nib, forCellReuseIdentifier: SchedulesTableViewCell.identifier)
//            tableView.refreshControl = UIRefreshControl()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
    */
//    @IBAction func makeScheduleButtonTapped(_ sender: Any) {
//        navigationController?.pushViewController(MakeScheduleViewController(), animated: true)
//    }
//    @IBAction func makeInputButtonTapped(_ sender: Any) {
//        navigationController?.pushViewController(InputScheduleViewController(), animated: true)
//    }
    
}

extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(InputScheduleViewController(), animated: true)
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
