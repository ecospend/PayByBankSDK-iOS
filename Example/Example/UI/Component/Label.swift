//
//  Label.swift
//  Example
//
//  Created by Berk Akkerman on 24.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
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
        textColor = .systemIndigo
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
}
