//
//  RegistrationViewModel.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 10/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsRegistering = Bindable<Bool>()
    
//    var image: UIImage? {
//        didSet {
//            imageObserver?(image)
//        }
//    }
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    func performRegistration(completion: @escaping (Error?) -> Void) {
        
        guard let email = email, let password = password else { return }
        
        bindableIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            print("user registered: \(String(describing: result?.user.uid))")
            
            guard let image = self.bindableImage.value else {
                fatalError("Image is missing")
            }
            
            StorageManager.shared.upload(image: image, completion: { (meta, url, error) in
                
                if let error = error {
                    completion(error)
                    return
                }
                
                self.bindableIsRegistering.value = false
                
                completion(nil)
                print("Finish uploading image to storage. Url: \(String(describing: url?.absoluteString))")
                
            })
            
        }
    }
    
    // Reactive programming
    var isFormValidObserver: ((Bool) -> Void)? = nil
//    var imageObserver: ((UIImage?) -> Void)? = nil
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    
}
