//
//  HUDManager.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 13/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation
import JGProgressHUD

class HUDManager {
    
    let hud = JGProgressHUD(style: .dark)
    
    static let shared = HUDManager()
    
    private init() {}
    
    func show(in view: UIView, title: String, description: String? = nil) {
        if hud.isVisible {
            hud.dismiss()
        }
        hud.textLabel.text = title
        hud.detailTextLabel.text = description
        hud.dismiss(afterDelay: 3.0)
        hud.show(in: view, animated: true)
    }
    
    func show(in view: UIView, error: Error) {
        show(in: view, title: "Error", description: error.localizedDescription)
    }
}
