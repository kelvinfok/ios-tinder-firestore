//
//  TopNavigationStackView.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 16/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let fireImageView = UIImageView()
        
        fireImageView.image = #imageLiteral(resourceName: "app_icon")
        fireImageView.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)

        [settingsButton, UIView(), fireImageView, UIView(), messageButton].forEach({
            addArrangedSubview($0)
        })
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
}
