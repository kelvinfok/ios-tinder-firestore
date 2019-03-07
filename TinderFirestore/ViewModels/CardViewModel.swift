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

struct CardViewModel {
    
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
}
