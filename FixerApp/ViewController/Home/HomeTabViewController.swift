//
//  HomeTabViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/27.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "未入力"
        homeVC.tabBarItem.tag = 1
        
        let homeVC2 = HomeViewController()
        homeVC2.tabBarItem.title = "入力済"
        homeVC2.tabBarItem.tag = 2
        
        let vcList: [UIViewController] = [ homeVC, homeVC2 ]
        setViewControllers(vcList, animated: true)
        

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

}
