//
//  HomeTabViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/27.
//

import UIKit
import LineSDK

enum EventStatus {
    case unentered
    case entered
    case confirmed
}

class HomeTabViewController: UITabBarController {
    private var jsonString : String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        
        let events = fetchEvents()
        
        guard let userID =  UserDefaults.standard.object(forKey: "userID") as? String else {
            print("userID取り出せないエラー")
            return
        }
        
        var unenteredEvents: [Event] = []
        var enteredEvents: [Event] = []
        var confirmedEvents: [Event] = []
        
        //イベントの振り分け
        for event in events {
            
            if event.isDecided {
                confirmedEvents.append(event)
                continue
            }
            
            var isDistributed = false
            
            for unenteredUser in event.unenteredUsers {
                if userID == unenteredUser.id {
                    unenteredEvents.append(event)
                    isDistributed = true
                    break
                }
            }
            guard isDistributed == false else { continue }
            enteredEvents.append(event)
//            for enteredUser in event.enteredUsers {
//                if userID == enteredUser.id {
//                    enteredEvents.append(event)
//                    isDistributed = true
//                    break
//                }
//            }
        }
        
        navigationItem.title = "Fixer"
        let newScheduleButtonItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(newButtonTapped(_:)))
        navigationItem.rightBarButtonItem = newScheduleButtonItem
        
        let homeVC = HomeViewController(events: unenteredEvents, status: EventStatus.unentered, jsonString: nil)
        homeVC.tabBarItem.title = "未入力"
        homeVC.tabBarItem.tag = 1
        homeVC.tabBarItem.badgeValue = "5"
        homeVC.tabBarItem.image = UIImage(named: "file")?.resize(width: 30)
    
        let homeVC2 = HomeViewController(events: enteredEvents, status: EventStatus.entered, jsonString: jsonString)
        homeVC2.tabBarItem.title = "入力済"
        homeVC2.tabBarItem.tag = 2
        homeVC2.tabBarItem.image = UIImage(named: "document")?.resize(width: 30)
        
        let homeVC3 = HomeViewController(events: confirmedEvents, status: EventStatus.confirmed, jsonString: jsonString)
        homeVC3.tabBarItem.title = "確定済"
        homeVC3.tabBarItem.tag = 3
        homeVC3.tabBarItem.image = UIImage(named: "check")?.resize(width: 30)
        
        let vcList: [UIViewController] = [ homeVC, homeVC2, homeVC3 ]
        setViewControllers(vcList, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
        private func fetchEvents() -> [Event] {
            let jsonString2 = """
            [
            {"possibleTimezones":[],"timezones":[{"from":20,"status":0,"to":24,"date":"2021-02-17T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-18T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-19T15:00:00Z"}],"id":0,"unenteredUsers":[{"id":"U45ff189e50f6ea19c1a4f11a57f885ce","name":"Kohei Keta","imageURL":"Optional(https://profile.line-scdn.net/0hB3aN4hK_HRxcNwt3c5diS2ByE3ErGRtUJFRTKnBnRX8lAV5CaVBUcn0zRHl1VA1NZlMAc3tgQH5x)"}],"deadline":"2021-02-13T09:33:00Z","isDecided":false,"enteredUsers":[],"name":"aiueo","makerId":"U45ff189e50f6ea19c1a4f11a57f885ce"},
            {"possibleTimezones":[{"from":20,"status":0,"to":24,"date":"2021-02-17T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-19T15:00:00Z"}],"timezones":[{"from":20,"status":0,"to":24,"date":"2021-02-17T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-18T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-19T15:00:00Z"}],"id":0,"unenteredUsers":[],"deadline":"2021-02-13T09:38:00Z","isDecided":false,"enteredUsers":[{"id":"U45ff189e50f6ea19c1a4f11a57f885ce","name":"Kohei Keta","imageURL":"Optional(https://profile.line-scdn.net/0hB3aN4hK_HRxcNwt3c5diS2ByE3ErGRtUJFRTKnBnRX8lAV5CaVBUcn0zRHl1VA1NZlMAc3tgQH5x)"}],"name":"2月打ち上げ！！","makerId":"U45ff189e50f6ea19c1a4f11a57f885ce"},
            {"possibleTimezones":[],"timezones":[{"from":20,"status":0,"to":24,"date":"2021-02-17T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-18T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-19T15:00:00Z"}],"id":0,"unenteredUsers":[{"id":"Uewrwerew844f11a57f885ce","name":"Tanaka","imageURL":"Optional(https://profile.line-scdn.net/0hB3aN4hK_HRxcNwt3c5diS2ByE3ErGRtUJFRTKnBnRX8lAV5CaVBUcn0zRHl1VA1NZlMAc3tgQH5x)"}],"deadline":"2021-02-13T10:38:00Z","isDecided":false,"enteredUsers":[{"id":"U45ff189e50f6ea19c1a4f11a57f885ce","name":"Kohei Keta","imageURL":"Optional(https://profile.line-scdn.net/0hB3aN4hK_HRxcNwt3c5diS2ByE3ErGRtUJFRTKnBnRX8lAV5CaVBUcn0zRHl1VA1NZlMAc3tgQH5x)"}],"name":"2月打ち上げ！！","makerId":"U45ff189e50f6ea19c1a4f11a57f885ce"},
            {"possibleTimezones":[],"timezones":[{"from":20,"status":0,"to":24,"date":"2021-02-17T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-18T15:00:00Z"},{"from":20,"status":0,"to":24,"date":"2021-02-19T15:00:00Z"}],"id":0,"unenteredUsers":[],"deadline":"2021-02-13T09:38:00Z","isDecided":true,
                "decidedTimezone":{"from":20,"status":0,"to":24,"date":"2021-02-17T15:00:00Z"},
                "enteredUsers":[{"id":"U45ff189e50f6ea19c1a4f11a57f885ce","name":"Kohei Keta","imageURL":"Optional(https://profile.line-scdn.net/0hB3aN4hK_HRxcNwt3c5diS2ByE3ErGRtUJFRTKnBnRX8lAV5CaVBUcn0zRHl1VA1NZlMAc3tgQH5x)"}],"name":"2月打ち上げ！！","makerId":"U45ff189e50f6ea19c1a4f11a57f885ce"},
            ]
            """
        
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let events = try decoder.decode([Event].self, from: jsonString2.data(using: .utf8)!)
                return events
            }
            catch let error {
               print(error)
                return []
            }
//            guard let events = try? decoder.decode([Event].self, from: jsonString2.data(using: .utf8)!) else {
//                print("error")
//                return []
//            }
//            return events
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
