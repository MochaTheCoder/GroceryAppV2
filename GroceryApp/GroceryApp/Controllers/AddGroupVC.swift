//
//  AddGroupVC.swift
//  GroceryApp
//
//  Created by Jonathan on 3/17/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import UIKit

class AddGroupVC: UIViewController {

    @IBOutlet private weak var groupNameTextfield: UITextField!
    @IBOutlet private weak var createGroupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGroupButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    }

    @objc private func createButtonPressed() {
        Group.createGroup(group: Group(name: groupNameTextfield.text ?? "Group name")) { (group, error) in
            if let error = error {
                self.present(error: error)
            } else {
                self.presentSuccess(message: "New group created!")
            }
        }
    }

}
