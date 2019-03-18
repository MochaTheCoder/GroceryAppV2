//
//  Date+GroceryApp.swift
//  GroceryApp
//
//  Created by Jonathan on 10/27/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import Foundation

extension Date {

    var isoString: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
    
}
