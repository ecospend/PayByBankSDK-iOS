//
//  PaylinkImages.swift
//  Paylink
//
//  Created by Yunus TÜR on 10.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

enum PaylinkImages: String {
    case close
}

extension PaylinkImages {
    
    var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle(for: Paylink.self), compatibleWith: nil)
    }
}
