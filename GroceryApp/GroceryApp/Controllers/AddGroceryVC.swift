//
//  AddGroceryVC.swift
//  GroceryApp
//
//  Created by Jonathan on 10/27/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class AddGroceryVC: UIViewController {

    @IBOutlet weak var searchBar: ImageTextField!
    @IBOutlet weak var searchTableview: UITableView!
    @IBOutlet weak var groceryImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addButtonPressed))

        searchBar.leftImage = #imageLiteral(resourceName: "magnifyGlass")
        searchBar.imageTextFieldDelegate = self
    }

    @objc func addButtonPressed() {
        if let name = searchBar.text {
            var newGrocery = NewGrocery(name: name)
            Grocery.createNew(grocery: &newGrocery) { (grocery, error) in
                print(grocery)
            }
            searchBar.text = ""
        }
    }

}

extension AddGroceryVC: ImageTextFieldDelegate {

    func imageTextField(_ imageTextField: ImageTextField, textChanged text: String) {
        // TODO: Search for stuff
    }

    func imageTextFieldShouldReturn(_ imageTextField: ImageTextField) -> Bool {
        return true
    }
    
}
