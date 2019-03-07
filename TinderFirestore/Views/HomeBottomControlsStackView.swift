//
//  HomeBottomControlsStackView.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 16/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].forEach { (image) in
            let button = UIButton(type: .system)
            let image = image.withRenderingMode(.alwaysOriginal)
            button.setImage(image, for: .normal)
            addArrangedSubview(button)
        }
        
        self.distribution = .fillEqually
        
    }
    
}
