//
//  GroceryCell.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class GroceryCell: UITableViewCell {
    @IBOutlet weak var groceryImageVIew: UIImageView!
    @IBOutlet weak var groceryName: UILabel!
    @IBOutlet weak var groceryQuantity: UILabel!
    
    func configure(grocery: Grocery) {
        self.groceryImageVIew.image = grocery.image
        self.groceryName.text = grocery.name
        self.groceryQuantity.text = String(grocery.quantity)
    }
}
