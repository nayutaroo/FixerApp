//
//  HomeTabViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/27.
//

import UIKit
import LineSDK

class HomeTabViewController: UITabBarController {
    private var jsonString : String? = nil

    override func viewDidLoad() {
    
    //(WIP)後々サーバからのレスポンスによって変更する
        jsonString = """
    [
            {"date": "2021-01-31T15:00:00Z","from": 16,"to": 20,"status": 0},
            {"date": "2021-01-31T15:00:00Z","from": 20,"to": 24,"status": 2},
            {"date": "2021-02-01T15:00:00Z","from": 16,"to": 19,"status": 1},
            {"date": "2021-02-01T15:00:00Z","from": 19,"to": 24,"status": 0},
            {"date": "2021-02-02T15:00:00Z","from": 16,"to": 17,"status": 2},
            {"date": "2021-02-02T15:00:00Z","from": 17,"to": 20,"status": 1},
            {"date": "2021-02-02T15:00:00Z","from": 20,"to": 24,"status": 0},
            {"date": "2021-02-03T15:00:00Z","from": 16,"to": 18,"status": 0},
            {"date": "2021-02-03T15:00:00Z","from": 18,"to": 24,"status": 2},
            {"date": "2021-02-04T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-05T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-06T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-07T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-08T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-09T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-10T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-11T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-12T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-13T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-14T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-15T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-16T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-17T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-18T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-19T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-20T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-21T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-22T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-23T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-24T15:00:00Z","from": 16,"to": 24,"status": 2},
            {"date": "2021-02-25T15:00:00Z","from": 16,"to": 24,"status": 0},
            {"date": "2021-02-26T15:00:00Z","from": 16,"to": 24,"status": 1},
            {"date": "2021-02-27T15:00:00Z","from": 16,"to": 24,"status": 2},
    ]
"""
        
        super.viewDidLoad()
        
        navigationItem.title = "Fixer"
        let newScheduleButtonItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(newButtonTapped(_:)))
        navigationItem.rightBarButtonItem = newScheduleButtonItem
        
        let homeVC = HomeViewController(jsonString: nil)
        homeVC.tabBarItem.title = "未入力"
        homeVC.tabBarItem.tag = 1
        homeVC.tabBarItem.badgeValue = "5"
        homeVC.tabBarItem.image = UIImage(named: "file")?.resize(width: 30)
    
        let homeVC2 = HomeViewController(jsonString: jsonString)
        homeVC2.tabBarItem.title = "入力済"
        homeVC2.tabBarItem.tag = 2
        homeVC2.tabBarItem.image = UIImage(named: "document")?.resize(width: 30)
        
        let homeVC3 = HomeViewController(jsonString: jsonString)
        homeVC3.tabBarItem.title = "確定済"
        homeVC3.tabBarItem.tag = 3
        homeVC3.tabBarItem.image = UIImage(named: "check")?.resize(width: 30)
        
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
    

    @objc func newButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(MakeScheduleViewController(), animated: true)
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
