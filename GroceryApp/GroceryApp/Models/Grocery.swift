//
//  Grocery.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

enum GroceryStatus: Int {
    case normal
    case crossedOff
    case deleted
}

class Grocery: FirebaseModel {

    var name: String?
    var imageUrl: String?
    var status: GroceryStatus = .normal

    init(name: String) {
        self.name = name
    }

    required init() {}

    override func createDict() -> [String : Any] {
        var dict = super.createDict()
        dict["name"] = name
        dict["imageUrl"] = imageUrl
        dict["status"] = status.rawValue
        return dict
    }

    override func map(objectDict: [String : Any]) {
        super.map(objectDict: objectDict)
        if let name = objectDict["name"] as? String {
            self.name = name
        }
        self.imageUrl = objectDict["image_url"] as? String
        if let status = objectDict["status"] as? Int {
            self.status = GroceryStatus.init(rawValue: status) ?? .normal
        }
    }

}

// MARK: - Network Requests

extension Grocery {

    static func fetchGroceries(completionHandler: @escaping (([Grocery], [Grocery], Error?) -> Void)) {
        var groceries = [Grocery]()
        var crossedGroceries = [Grocery]()
        Network.database.child("Grocery").observeSingleEvent(of: .value) { (snapshot) in

            if let groceryDicts = snapshot.value as? [String: [String: Any]] {
                for groceryDict in groceryDicts {
                    if let grocery: Grocery = Grocery.createNew(objectJson: (groceryDict.key, groceryDict.value)) {
                        if grocery.status == .normal {
                            groceries.append(grocery)
                        }
                        if grocery.status == .crossedOff {
                            crossedGroceries.append(grocery)
                        }
                    } else {
                        print(groceryDict)
                    }
                }
                completionHandler(groceries, crossedGroceries, nil)
            } else {
                completionHandler([], [], .firebaseError)
            }
        }
    }

    static func createNew(grocery: Grocery, completionHandler: @escaping((Grocery?, Error?) -> Void)) {
        let newRef = Network.database.child("Grocery").childByAutoId()
        grocery.setId(newRef.key)
        newRef.setValue(grocery.createDict()) { (error, ref) in
            if error == nil {
                completionHandler(grocery, nil)
            } else {
                completionHandler(nil, .firebaseError)
            }
        }
    }

    static func delete(grocery: Grocery, completionHandler: @escaping(Error?) -> Void) {
        let ref = Network.database.child("Grocery").child(grocery.getId())
        ref.updateChildValues(["status": GroceryStatus.deleted.rawValue]) { (error, _) in
            completionHandler(.firebaseError)
        }
    }

    static func batchDelete(crossedGroceries: [Grocery], completionHandler: @escaping(Error?) -> Void) {
        var deletedRefsQueue = Set<String>()
        for grocery in crossedGroceries {
            let ref = Network.database.child("Grocery").child(grocery.getId())
            deletedRefsQueue.insert(ref.key)
            ref.updateChildValues(["status": GroceryStatus.deleted.rawValue]) { (error, ref) in
                if error != nil {
                    completionHandler(.firebaseError)
                } else {
                    deletedRefsQueue.remove(ref.key)
                    if deletedRefsQueue.isEmpty {
                        completionHandler(nil)
                    }
                }
            }
        }
    }

}
