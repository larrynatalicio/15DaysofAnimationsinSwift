//
//  Sonar.swift
//  MapLocationAnimation
//
//  Created by Larry Natalicio on 4/17/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit
import MapKit

class SonarAnnotationView: MKAnnotationView {
    
    // MARK: - Types
    
    struct Constants {
        struct ColorPalette {
            static let green = UIColor(red:0.00, green:0.87, blue:0.71, alpha:1.0)
        }
    }
    
    // MARK: - Initializers
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        startAnimation()
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Convenience
    
    func sonar(_ beginTime: CFTimeInterval) {
        // The circle in its smallest size.
        let circlePath1 = UIBezierPath(arcCenter: self.center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)

        // The circle in its largest size.
        let circlePath2 = UIBezierPath(arcCenter: self.center, radius: CGFloat(80), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        // Configure the layer.
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = Constants.ColorPalette.green.cgColor
        shapeLayer.fillColor = Constants.ColorPalette.green.cgColor
        // This is the path that's visible when there'd be no animation.
        shapeLayer.path = circlePath1.cgPath
        self.layer.addSublayer(shapeLayer)
        
        // Animate the path.
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = circlePath1.cgPath
        pathAnimation.toValue = circlePath2.cgPath
        
        // Animate the alpha value.
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.8
        alphaAnimation.toValue = 0
        
        // We want both path and alpha animations to run together perfectly, so
        // we put them into an animation group.
        let animationGroup = CAAnimationGroup()
        animationGroup.beginTime = beginTime
        animationGroup.animations = [pathAnimation, alphaAnimation]
        animationGroup.duration = 2.76
        animationGroup.repeatCount = FLT_MAX
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards
        
        // Add the animation to the layer.
        shapeLayer.add(animationGroup, forKey: "sonar")
    }
    
    func startAnimation() {
        sonar(CACurrentMediaTime())
        sonar(CACurrentMediaTime() + 0.92)
        sonar(CACurrentMediaTime() + 1.84)
    }
    
}
