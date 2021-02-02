//
//  HomeTabViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/27.
//

import UIKit
import LineSDK

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Fixer"
//
//        navigationController?.navigationBar.titleTextAttributes
//            = [
//                NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 24)!,
//                .foregroundColor: UIColor.white
//            ]
//        navigationController?.navigationBar.backgroundColor = .black
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "未入力"
        homeVC.tabBarItem.tag = 1
        
        let homeVC2 = HomeViewController()
        homeVC2.tabBarItem.title = "入力済"
        homeVC2.tabBarItem.tag = 2
        
        let homeVC3 = HomeViewController()
        homeVC3.tabBarItem.title = "確定済"
        homeVC3.tabBarItem.tag = 3
        
        let vcList: [UIViewController] = [ homeVC, homeVC2, homeVC3 ]
        setViewControllers(vcList, animated: true)
        
//        // LINE ログインプロフィールの取得
//        API.getProfile { result in
//            switch result {
//            case .success(let profile):
//                print("User ID: \(profile.userID)")
//                print("User Display Name: \(profile.displayName)")
//                print("User Status Message: \(profile.statusMessage)")
//                print("User Icon: \(String(describing: profile.pictureURL))")
//            case .failure(let error):
//                print(error)
//            }
//        }
        

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
