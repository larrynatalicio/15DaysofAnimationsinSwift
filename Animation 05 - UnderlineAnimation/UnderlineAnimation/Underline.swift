//
//  Underline.swift
//  UnderlineAnimation
//
//  Created by Larry Natalicio on 4/20/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

@IBDesignable
class Underline: UIView {
    
    // MARK: - Types
    
    struct Constants {
        struct ColorPalette {
            static let green = UIColor(red:0.00, green:0.87, blue:0.71, alpha:1.0)
        }
    }

    // MARK: - Initiazlizers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    // MARK: - Convenience
    
    func commonInit() {
        self.backgroundColor = Constants.ColorPalette.green
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
}

