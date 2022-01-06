//
//  Button.swift
//  Example
//
//  Created by Berk Akkerman on 24.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        isExclusiveTouch = true
        setShadow()
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemIndigo
        titleLabel?.font = Font.primary
        layer.cornerRadius = frame.height / 2
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
