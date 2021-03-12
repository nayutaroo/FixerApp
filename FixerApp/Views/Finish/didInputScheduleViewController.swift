//
//  didInputScheduleViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/13.
//

import UIKit

class didInputScheduleViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
