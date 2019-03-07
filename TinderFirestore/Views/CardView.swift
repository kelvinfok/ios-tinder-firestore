//
//  CardView.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 16/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: cardViewModel.imageName)
            infoLabel.attributedText = cardViewModel.attributedString
            infoLabel.textAlignment = cardViewModel.textAlignment
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(infoLabel)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        infoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.leading).offset(16)
            make.trailing.equalTo(imageView.snp.trailing).offset(-16)
            make.bottom.equalTo(imageView.snp.bottom).offset(-16)
        }
        imageView.setCornerRadius(value: 12)
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
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
