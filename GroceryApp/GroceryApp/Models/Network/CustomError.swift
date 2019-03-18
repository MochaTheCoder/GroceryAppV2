//
//  CustomError.swift
//  GroceryApp
//
//  Created by Jonathan on 3/17/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import Foundation

enum Error {
    case networkError
    case firebaseError

    var description: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .firebaseError:
            return "Firebase Error"
        }
    }
}
