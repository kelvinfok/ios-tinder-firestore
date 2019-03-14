//
//  UIImageView.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 14/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        sd_setImage(with: url, completed: nil)
    }

}

