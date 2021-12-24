//
//  Label.swift
//  Example
//
//  Created by Berk Akkerman on 24.12.2021.
//

import UIKit

class Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    func setupLabel() {
        textColor = Color.blueMartina
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
}
