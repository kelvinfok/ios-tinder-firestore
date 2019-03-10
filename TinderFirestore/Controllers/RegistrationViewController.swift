//
//  RegistrationViewController.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 10/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
        
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [selectPhotoButton,
                                                fullNameTextField,
                                                emailTextField,
                                                passwordTextField,
                                                registerButton])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setCornerRadius(value: 16)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 0, alpha: 0.1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter email"
        tf.backgroundColor = .white
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupViews()
    }
    
    func setupViews() {
        
        view.addSubview(stackView)
        
        selectPhotoButton.snp.makeConstraints({ (make) in
            make.height.equalTo(selectPhotoButton.snp.width)
        })
        
        stackView.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
            make.leading.equalTo(view.snp.leading).offset(48)
            make.trailing.equalTo(view.snp.trailing).offset(-48)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        registerButton.setCornerRadius(value: 25)
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor(hexFromString: "FD5B5F")
        let bottomColor = UIColor(hexFromString: "E50072")
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
}

