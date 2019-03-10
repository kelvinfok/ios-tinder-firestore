//
//  ViewController.swift
//  TinderFirestore
//
//  Created by Kelvin Fok on 12/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let tabBarStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()
    
    let cardViewModels = ([
        User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
        Advertiser(title: "Slide out menu", brandName: "Let's Build that app", posterPhotoName: "slide_out_menu_poster"),
        User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
        ] as [ProducesCardViewModel]).map { (producer) -> CardViewModel in
            return producer.toCardViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDummyCards()
        setupNavigation()
    }
    
    // MARK: - SetupViews
    
    func setupViews() {

        let mainStackView = FastObjectHelper.createStackView(items: [topStackView, cardsDeckView, tabBarStackView],
                                                             axis: .vertical, distribution: .fill, alignment: .fill)
        
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        mainStackView.bringSubviewToFront(cardsDeckView)
        
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        topStackView.snp.makeConstraints { (make) in
            make.height.equalTo(80)
        }
        
        tabBarStackView.snp.makeConstraints { (make) in
            make.height.equalTo(120)
        }
    }
    
    func setupDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperView()
        }
    }
    
    func setupNavigation() {
        topStackView.settingsButton.addTarget(self, action: #selector(settingsButtonTapped(_:)), for: .touchUpInside)
        topStackView.messageButton.addTarget(self, action: #selector(messageButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func settingsButtonTapped(_ item: UIBarButtonItem) {
        let controller = RegistrationViewController()
        present(controller, animated: true, completion: nil)
    }
    
    @objc func messageButtonTapped(_ item: UIBarButtonItem) {
        print("show message")

    }
}

