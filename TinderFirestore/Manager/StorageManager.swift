//
//  StorageManager.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 13/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageManager {
    
    private let storage = Storage.storage()
    private let imagePath = "/images/"
    private let imageExtension = ".jpg"

    private init() {}
    
    static let shared = StorageManager()
    
    func upload(image: UIImage,
                with fileName: String = UUID().uuidString,
                completion: ((StorageMetadata?, URL?, Error?) -> Void)? = nil) {
        
        let path = imagePath.appending(fileName).appending(imageExtension)
        let storageReference = storage.reference(withPath: path)
        let imageData = image.jpegData(compressionQuality: Config.jpgCompressionQuality) ?? Data()
        storageReference.putData(imageData, metadata: nil) { (meta, error) in
            var _error: Error? = error
            storageReference.downloadURL(completion: { (url, error) in
                // Returns the download URL
                _error = error
                completion?(meta, url, _error)
            })
        }
    }
}
