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
    
    func save(to collection: Collection,
              path: String,
              document: [String : Any],
              completion: @escaping (Error?) -> Void) {
        
        store.collection(collection.rawValue)
            .document(path)
            .setData(document, completion: completion)
    }
    
    func save<T: Encodable>(to collection: Collection, path: String, object: T, completion: @escaping (Error?) -> Void) {
        do {
            let data = try JSONEncoder().encode(object)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            store.collection(collection.rawValue).document(path).setData(dictionary, completion: completion)
        } catch(let error) {
            completion(error)
        }
    }
    
    func fetch<T: Decodable>(from collection: Collection, completion: @escaping ([T]?, Error?) -> Void) {
        
        store.collection(collection.rawValue).getDocuments { (snapshot, error) in

            var objects = [T]()
            var err: Error? = error

            snapshot?.documents.forEach({ (documentSnapshot) in

                let dictionary = documentSnapshot.data()

                do {
                    let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    objects.append(decoded)
                } catch(let error) {
                    err = error
                    print(error)
                }
            })
            completion(objects, err)
        }
    }
}
