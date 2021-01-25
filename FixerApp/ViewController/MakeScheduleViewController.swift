//
//  MakeScheduleViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/24.
//

import UIKit

class MakeScheduleViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var makeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeButton.layer.cornerRadius = 10
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 700)
        scrollView.isScrollEnabled = true

        // Do any additional setup after loading the view.
 
    }
    @IBAction func makeButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(InputScheduleViewController(), animated: true)
    }
}
