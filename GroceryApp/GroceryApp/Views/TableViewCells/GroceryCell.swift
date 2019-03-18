//
//  GroceryCell.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class GroceryCell: UITableViewCell {

    @IBOutlet private weak var groceryImageVIew: UIImageView!
    @IBOutlet private weak var groceryNameLabel: UILabel!

    var grocery: Grocery?
    
    func configure(grocery: Grocery) {
        guard let groceryName = grocery.name else { return }
        groceryImageVIew.image = nil
        self.grocery = grocery
        if grocery.status == .crossedOff {
            let attributedString = NSMutableAttributedString(string: groceryName)
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            groceryNameLabel.attributedText = attributedString
        } else {
            groceryNameLabel.attributedText = nil
            groceryNameLabel.text = grocery.name
        }
    }
}
