//
//  LoginViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/28.
//

import LineSDK
import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Login Button.
        let loginButton = LoginButton()
        loginButton.delegate = self
        
        // Configuration for permissions and presenting.
        loginButton.permissions = [.profile]
        loginButton.presentingViewController = self
        
        // Add button to view and layout it.
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        // Do any additional setup after loading the view.
        
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ button: LoginButton, didSucceedLogin loginResult: LoginResult) {
//        hideIndicator()
        print("Login Succeeded.")
        // LINE ログインプロフィールの取得
        API.getProfile { result in
            switch result {
            case .success(let profile):
//                print("User ID: \(profile.userID)")
//                print("User Display Name: \(profile.displayName)")
//                print("User Status Message: \(profile.statusMessage)")
//                print("User Icon: \(String(describing: profile.pictureURL))")
                
                UserDefaults.standard.setValue(profile.userID, forKey: "userID")
                UserDefaults.standard.setValue(profile.displayName, forKey: "userName")
                UserDefaults.standard.setValue(String(describing: profile.pictureURL), forKey: "userImageUrl")
                
            case .failure(let error):
                print(error)
            }
        }
        navigationController?.pushViewController(HomeTabViewController(), animated: true)
    }
    
    func loginButton(_ button: LoginButton, didFailLogin error: LineSDKError) {
//        hideIndicator()
        print("Error: \(error)")
    }
    
    func loginButtonDidStartLogin(_ button: LoginButton) {
//        showIndicator()
        print("Login Started.")
    }
}
