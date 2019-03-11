//
//  Binable.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 11/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> Void)? = nil
    
    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
}
