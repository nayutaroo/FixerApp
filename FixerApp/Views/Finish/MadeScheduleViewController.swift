//
//  MadeScheduleViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/03.
//

import UIKit

class MadeScheduleViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
