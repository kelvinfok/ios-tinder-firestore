//
//  FastObjectHelper.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 12/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

struct FastObjectHelper {
    
    static func createView(backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
    
    static func createStackView(items: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment) -> UIStackView {
        let view = UIStackView(arrangedSubviews: items)
        view.axis = axis
        view.alignment = alignment
        view.distribution = distribution
        return view
    }
    
}
