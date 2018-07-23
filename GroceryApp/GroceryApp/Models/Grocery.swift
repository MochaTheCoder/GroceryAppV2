//
//  Grocery.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class Grocery {
    
    static let testGroceries = [ Grocery(name: "Apple", image: nil, quantity: 5, crossedOff: false), Grocery(name: "Celery", image: nil, quantity: 2, crossedOff: false)]
    var name: String
    var image = UIImage()
    var crossedOff: Bool
    var quantity: Int
    
    init(name: String, image: UIImage?, quantity: Int, crossedOff: Bool) {
        self.name = name
        self.quantity = quantity
        if let image = image {
            self.image = image
        }
        self.crossedOff = crossedOff
    }
}
