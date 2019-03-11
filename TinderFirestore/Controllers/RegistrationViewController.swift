//
//  RegistrationViewController.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 10/3/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationViewController: UIViewController {
    
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let registrationViewModel = RegistrationViewModel()
    
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
        button.addTarget(self, action: #selector(handleSelectPhoto(_:)), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegister(_:)), for: .touchUpInside)
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter full name"
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter email"
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 48)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupViews()
        setupObservers()
        setupGesture()
        setupRegistrationViewObserver()
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
    
    @objc fileprivate func handleSelectPhoto(_ button: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    fileprivate func setupRegistrationViewObserver() {
        registrationViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
            if isFormValid {
                self.registerButton.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
            } else {
                self.registerButton.backgroundColor = .lightGray
            }
            self.registerButton.isEnabled = isFormValid
        }
        
        registrationViewModel.bindableImage.bind { [unowned self] (image) in
            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
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
    
     @objc fileprivate func handleTextChanged(_ textfield: UITextField) {
        let text = textfield.text
        switch textfield {
        case fullNameTextField:
            registrationViewModel.fullName = text
        case emailTextField:
            registrationViewModel.email = text
        case passwordTextField:
            registrationViewModel.password = text
        default: break
        }
    }
    
    @objc func handleRegister(_ button: UIButton) {
        
        handleViewTap()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                self.showHUDWithError(error: error)
                return
            }
            
            print("user registered: \(result?.user.uid)")
            
        }
    }
    
    fileprivate func showHUDWithError(error: Error) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: view)
        hud.dismiss(afterDelay: 4.0)
    }
}


extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        
        registrationViewModel.bindableImage.value = image
//         registrationViewModel.image = image
        dismiss(animated: true, completion: nil)
    }

}
