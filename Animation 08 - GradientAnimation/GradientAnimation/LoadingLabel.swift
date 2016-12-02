//
//  LoadingLabel.swift
//  GradientAnimation
//
//  Created by Larry Natalicio on 4/23/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

@IBDesignable
class LoadingLabel: UIView {
    
    // MARK: - Types
    
    struct Constants {
        struct Fonts {
            static let loadingLabel = "HelveticaNeue-UltraLight"
        }
    }
    
    // MARK: - Properties

    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // Configure gradient.
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        gradientLayer.colors = colors
        
        let locations = [0.25, 0.5, 0.75]
        gradientLayer.locations = locations as [NSNumber]?
        
        return gradientLayer
    }()
    
    let textAttributes: [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        return [NSFontAttributeName: UIFont(name: Constants.Fonts.loadingLabel, size: 70.0)!, NSParagraphStyleAttributeName: style]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
            // Create a temporary graphic context in order to render the text as an image.
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.draw(in: bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Use image to create a mask on the gradient layer.
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image?.cgImage
            
            gradientLayer.mask = maskLayer
        }
    }
    
    // MARK: - View Life Cycle
    
    override func layoutSubviews() {
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 2 * bounds.size.width, height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 1.7
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        
        gradientLayer.add(gradientAnimation, forKey: nil)
    }

}
