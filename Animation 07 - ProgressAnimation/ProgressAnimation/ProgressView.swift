//
//  ProgressView.swift
//  ProgressAnimation
//
//  Created by Larry Natalicio on 4/22/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressView: UIView {
    
    // MARK: - Types
    
    struct Constants {
        struct ColorPalette {
            static let teal = UIColor(red:0.27, green:0.80, blue:0.80, alpha:1.0)
            static let orange = UIColor(red:0.90, green:0.59, blue:0.20, alpha:1.0)
            static let pink = UIColor(red:0.98, green:0.12, blue:0.45, alpha:1.0)
        }
    }
    
    // MARK: - Properties

    let progressLayer = CAShapeLayer()
    let gradientLayer = CAGradientLayer()
    
    var range: CGFloat = 128
    var curValue: CGFloat = 0 {
        didSet {
            animateStroke()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayers()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // prepareForInterfaceBuilder is used with @IBDesignable to display
        // this view in the Storyboard.
        setupLayers()
    }
    
    // MARK: - Convenience
    
    func setupLayers() {
        
        // Setup progress layer.
        progressLayer.position = CGPointZero
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0.0
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor

        let radius = CGFloat(self.bounds.height/2) - progressLayer.lineWidth
        let startAngle = CGFloat(-M_PI / 2)
        let endAngle = CGFloat(3 * M_PI / 2)
        let width = CGRectGetWidth(self.bounds)
        let height = CGRectGetHeight(self.bounds)
        let modelCenter = CGPointMake(width / 2, height / 2)
        let path = UIBezierPath(arcCenter: modelCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        progressLayer.path = path.CGPath

        layer.addSublayer(progressLayer)
        
        // Setup gradient layer.
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds))
        gradientLayer.colors = [Constants.ColorPalette.teal.CGColor, Constants.ColorPalette.orange.CGColor, Constants.ColorPalette.pink.CGColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.mask = progressLayer // Use progress layer as mask for gradient layer.
        layer.addSublayer(gradientLayer)
    }
    
    func animateStroke() {
        let fromValue = progressLayer.strokeEnd
        let toValue = curValue / range
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        progressLayer.addAnimation(animation, forKey: "stroke")
        progressLayer.strokeEnd = toValue
    }

}

