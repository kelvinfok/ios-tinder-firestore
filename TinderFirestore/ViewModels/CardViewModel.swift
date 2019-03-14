//
//  CardViewModel.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 6/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    // Reactive programming
    
    var imageIndexObserver: ((Int, String) -> Void)? = nil
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageUrl = imageNames[imageIndex]
            imageIndexObserver?(imageIndex, imageUrl)
        }
    }
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func advanceToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
    
}
