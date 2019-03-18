//
//  UIViewController+GroceryApp.swift
//  GroceryApp
//
//  Created by Jonathan on 3/17/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import UIKit

extension UIViewController {

    func present(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }

    func presentSuccess(message: String, title: String? = "Success!") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
