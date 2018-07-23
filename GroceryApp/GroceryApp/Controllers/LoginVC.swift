//
//  LoginVC.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var usernamePassword: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        let tabBar = UITabBarController()
        let groceriesVC = UINavigationController(rootViewController: GroceriesVC())
        groceriesVC.navigationBar.isHidden = true
        groceriesVC.tabBarItem = UITabBarItem(title: "Groceries", image: nil, selectedImage: nil)
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        
        tabBar.viewControllers = [groceriesVC, profileVC]
        self.navigationController?.present(tabBar,animated: true, completion: nil)
    }
}
