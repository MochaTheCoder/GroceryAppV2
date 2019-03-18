//
//  FirebaseModel.swift
//  GroceryApp
//
//  Created by Jonathan on 10/27/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseModel {

    private var id: String?
    var creationDate = Date().isoString
    var creatorId: String = Auth.auth().currentUser?.uid ?? ""
    
    required init() {}

    func getId() -> String {
        guard let id = id else {
            fatalError("id is never set. Create a new childByAutoId before adding to firebase")
        }
        return id
    }

    func setId(_ id: String) {
        self.id = id
    }
    
    func createDict() -> [String: Any] {
        return ["creation_date": Date().isoString,
                "creator_id": creatorId]
    }

    func map(objectDict: [String: Any]) {
        if let creationDate = objectDict["creation_date"] as? String {
            self.creationDate = creationDate
        }
        if let creatorId = objectDict["creator_id"] as? String {
            self.creatorId = creatorId
        }
    }

    class func createNew<T: FirebaseModel>(objectJson: (objectId: String, value: Any)) -> T? {
        guard let objectDict = objectJson.value as? [String: Any] else { return nil }
        let newT = T()
        newT.map(objectDict: objectDict)
        return newT
    }
    
}

