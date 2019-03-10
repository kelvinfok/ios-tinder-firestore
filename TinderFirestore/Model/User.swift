//
//  User.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 23/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString.init(string: " \(age)", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString.init(string: "\n\(profession)", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)

    }
    
}

