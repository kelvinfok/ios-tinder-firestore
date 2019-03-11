//
//  RegistrationViewModel.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 10/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    
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
    
    // Reactive programming
    var isFormValidObserver: ((Bool) -> Void)? = nil
//    var imageObserver: ((UIImage?) -> Void)? = nil
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    
}
