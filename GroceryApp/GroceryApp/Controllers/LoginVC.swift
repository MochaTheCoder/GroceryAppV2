//
//  LoginVC.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var usernamePassword: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }
    
//    @objc func loginButtonPressed() {
//
//        let tabBar = UITabBarController()
//        let groceriesVC = UINavigationController(rootViewController: GroceriesVC())
//
//        let profileVC = ProfileVC()
//        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
//
//        tabBar.viewControllers = [groceriesVC, profileVC]
//        self.navigationController?.present(tabBar,animated: true, completion: nil)
//    }
    
    private func presentNextController() {
        let tabBar = UITabBarController()
        let groceriesVC = UINavigationController(rootViewController: GroceriesVC())
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        
        tabBar.viewControllers = [groceriesVC, profileVC]
        self.navigationController?.present(tabBar,animated: true, completion: nil)
    }
    
    @objc func registerButtonPressed() {
        let email = self.usernameTextField.text ?? ""
        let password = self.usernamePassword.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                if let currentUser = Auth.auth().currentUser {
//                    Network.network.currentUser = currentUser
                    self.presentNextController()
                }
            }
        }
    }
    
    @objc func loginButtonPressed() {
//        let email = self.usernameTextField.text ?? ""
//        let password = self.usernamePassword.text ?? ""
        let email = "firstUser@test.com"
        let password = "aaaAAA1!"
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                if let currentUser = Auth.auth().currentUser {
//                    Network.network.currentUser = currentUser
                    self.presentNextController()
                }
            }
        }
    }
}
