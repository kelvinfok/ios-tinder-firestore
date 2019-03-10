//
//  CardView.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 16/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    fileprivate let barSelectedColor = UIColor.white

    let barsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        sv.distribution = .fillEqually
        return sv
    }()
    
    var cardViewModel: CardViewModel! {
        didSet {
            setupIndexImageObserver()
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            infoLabel.attributedText = cardViewModel.attributedString
            infoLabel.textAlignment = cardViewModel.textAlignment
            updateBars()
        }
    }
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()
    
    fileprivate let threshold: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        setupGradientLayer()
        addSubview(infoLabel)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        infoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.leading).offset(16)
            make.trailing.equalTo(imageView.snp.trailing).offset(-16)
            make.bottom.equalTo(imageView.snp.bottom).offset(-16)
        }
        setCornerRadius(value: 12)
        imageView.contentMode = .scaleAspectFill
        setupBars()
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: nil)
        let midPoint = frame.width / 2
        if location.x < midPoint {
            cardViewModel.advanceToPreviousPhoto()
        } else if location.x > midPoint {
            cardViewModel.advanceToNextPhoto()
        }
    }
    
    fileprivate func setupIndexImageObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (index, image) in
            self.imageView.image = image
            self.updateBarSelection(index: index)
        }
    }
    
    fileprivate func updateImage(index: Int) {
        guard cardViewModel.imageNames.indices.contains(index) else { return }
        let imageName = cardViewModel.imageNames[index]
        imageView.image = UIImage(named: imageName)
    }
    
    fileprivate func updateBarSelection(index: Int) {
        guard barsStackView.arrangedSubviews.indices.contains(index) else { return }
        barsStackView.arrangedSubviews.forEach({ $0.backgroundColor = barDeselectedColor })
        barsStackView.arrangedSubviews[index].backgroundColor = barSelectedColor
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupBars() {
        addSubview(barsStackView)
        barsStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(snp.leading).offset(8)
            make.top.equalTo(snp.top).offset(8)
            make.trailing.equalTo(snp.trailing).offset(-8)
            make.height.equalTo(4)
        }
    }
    
    fileprivate func updateBars() {
        (0..<cardViewModel.imageNames.count).forEach { _ in
            let barView = UIView()
            barView.backgroundColor = barDeselectedColor
            barsStackView.addArrangedSubview(barView)
        }
        barsStackView.arrangedSubviews.first?.backgroundColor = barSelectedColor
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            break
        }
    }
    
    func handleChanged(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)
        let x = translation.x
        let y = translation.y
        
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: x, y: y)
    }
    
    func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard: Bool = abs(gesture.translation(in: nil).x) > threshold
            
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }, completion: { _ in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        })
    }
}
