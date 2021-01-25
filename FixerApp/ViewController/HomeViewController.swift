//
//  HomeViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/25.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var makeScheduleButton: UIButton!
    @IBOutlet weak var inputScheduleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fixer"
        navigationController?.navigationBar.titleTextAttributes
            = [
                NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 24)!,
                .foregroundColor: UIColor.white
            ]
        navigationController?.navigationBar.backgroundColor = .black

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
    @IBAction func makeScheduleButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(MakeScheduleViewController(), animated: true)
    }
    @IBAction func makeInputButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(InputScheduleViewController(), animated: true)
    }
    
}
