//
//  RegistrationViewController.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 10/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [fullNameTextField,
                                                emailTextField,
                                                passwordTextField,
                                                registerButton])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
        
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [selectPhotoButton,
                                                verticalStackView])
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
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter email"
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupViews()
        setupObservers()
        setupGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
    
    func setupViews() {
        
        view.addSubview(stackView)
        
        selectPhotoButton.snp.makeConstraints({ (make) in
            make.height.equalTo(selectPhotoButton.snp.width)
            make.width.equalTo(275)
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
    
    fileprivate func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleViewTap() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleKeyboardShow(_ notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        // bottom space is space between the bottom of the stackview and the superview
        let padding: CGFloat = 16
        let difference = keyboardFrame.height - bottomSpace + padding
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference)
    }
    
    fileprivate func setupGradientLayer() {
        let topColor = UIColor(hexFromString: "FD5B5F")
        let bottomColor = UIColor(hexFromString: "E50072")
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
}

