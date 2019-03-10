//
//  UIView.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 16/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillSuperView() {
        guard let superView = self.superview else { fatalError("No superview found") }
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(superView)
        }
    }
    
    func setCornerRadius(value: CGFloat) {
        layer.cornerRadius = value
        layer.masksToBounds = true
    }
    
    func setRoundedCorners() {
        setCornerRadius(value: frame.height / 2)
    }
    
}
