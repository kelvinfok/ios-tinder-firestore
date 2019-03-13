//
//  FirestoreManager.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 13/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import FirebaseFirestore

class FirestoreManager {
    
    enum Collection: String {
        case user = "user"
    }
    
    static let shared = FirestoreManager()
    
    let store = Firestore.firestore()
    
    private init() {}
    
    func save(to collection: Collection, path: String, document: [String : Any], completion: @escaping (Error?) -> Void) {
        store.collection(collection.rawValue).document(path).setData(document, completion: completion)
    }
}
