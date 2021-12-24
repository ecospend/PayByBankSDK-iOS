//
//  TextField.swift
//  Example
//
//  Created by Berk Akkerman on 24.12.2021.
//

import UIKit

class TextField: UITextField {
    
    struct Constants {
        static let sidePadding: CGFloat = 10
        static let topPadding: CGFloat = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + Constants.sidePadding,
            y: bounds.origin.y + Constants.topPadding,
            width: bounds.size.width - Constants.sidePadding * 2,
            height: bounds.size.height - Constants.topPadding * 2
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField() {
        borderStyle = .none
        layer.cornerRadius = 8
        backgroundColor = Color.mediterranean
        textColor = .white
    }
}
