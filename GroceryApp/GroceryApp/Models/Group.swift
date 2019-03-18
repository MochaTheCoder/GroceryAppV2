//
//  Group.swift
//  GroceryApp
//
//  Created by Jonathan on 3/17/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class Group: FirebaseModel {

    var name: String?

    required init() {}

    init(name: String) {
        self.name = name
    }

    override func createDict() -> [String : Any] {
        var dict = super.createDict()
        dict["name"] = name
        return dict
    }

    override func map(objectDict: [String : Any]) {
        super.map(objectDict: objectDict)
        if let name = objectDict["name"] as? String {
            self.name = name
        }
    }

}

extension Group {

    static func fetchGroups(completionHandler: @escaping ([Group], Error?) -> Void) {
        var groups = [Group]()
        Network.database.child("Group").observeSingleEvent(of: .value) { (snapshot) in
            guard let groupDicts = snapshot.value as? [String: [String: Any]] else {
                completionHandler([], .firebaseError)
                return
            }
            for groupDict in groupDicts {
                if let group: Group = Group.createNew(objectJson: (groupDict.key, groupDict.value)) {
                    groups.append(group)
                }
            }
            completionHandler(groups, nil)
        }
    }

    static func createGroup(group: Group, completionHandler: @escaping (Group?, Error?) -> Void) {
        let newRef = Network.database.child("Group").childByAutoId()
        group.setId(newRef.key)
        newRef.setValue(group.createDict()) { (error, ref) in
            if let error = error {
                completionHandler(nil, .firebaseError)
            } else {
                completionHandler(group, nil)
            }
        }
    }

}
