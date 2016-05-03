//
//  CALayerAnimationExtension.swift
//  SecretTextAnimation
//
//  Created by Larry Natalicio on 4/27/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import Foundation
import QuartzCore

class CLMLayerAnimation: NSObject {
    
    // MARK: - Properties
    
    var completionClosure: ((finished: Bool)-> ())? = nil
    var layer: CALayer!
    
    // MARK: - Convenience
    
    class func animation(layer: CALayer, duration: NSTimeInterval, delay: NSTimeInterval, animations: (() -> ())?, completion: ((finished: Bool)-> ())?) -> CLMLayerAnimation {
        
        let animation = CLMLayerAnimation()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            var animationGroup: CAAnimationGroup?
            let oldLayer = self.animatableLayerCopy(layer)
            animation.completionClosure = completion
            
            if let layerAnimations = animations {
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                layerAnimations()
                CATransaction.commit()
            }
            
            animationGroup = self.groupAnimationsForDifferences(oldLayer, newLayer: layer)
            
            if let differenceAnimation = animationGroup {
                differenceAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                differenceAnimation.duration = duration
                differenceAnimation.beginTime = CACurrentMediaTime()
                differenceAnimation.delegate = animation
                layer.addAnimation(differenceAnimation, forKey: nil)
            }else{
                if let completion = animation.completionClosure {
                    completion(finished: true)
                }
            }
        }
        
        return animation
    }
    
    class func groupAnimationsForDifferences(oldLayer: CALayer, newLayer: CALayer) -> CAAnimationGroup? {
        var animationGroup: CAAnimationGroup?
        var animations = [CABasicAnimation]()
        
        if !CATransform3DEqualToTransform(oldLayer.transform, newLayer.transform) {
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(CATransform3D: oldLayer.transform)
            animation.toValue = NSValue(CATransform3D: newLayer.transform)
            animations.append(animation)
        }
        
        if !CGRectEqualToRect(oldLayer.bounds, newLayer.bounds) {
            let animation = CABasicAnimation(keyPath: "bounds")
            animation.fromValue = NSValue(CGRect: oldLayer.bounds)
            animation.toValue = NSValue(CGRect: newLayer.bounds)
            animations.append(animation)
        }
        
        if !CGRectEqualToRect(oldLayer.frame, newLayer.frame) {
            let animation = CABasicAnimation(keyPath: "frame")
            animation.fromValue = NSValue(CGRect: oldLayer.frame)
            animation.toValue = NSValue(CGRect: newLayer.frame)
            animations.append(animation)
        }
        
        if !CGPointEqualToPoint(oldLayer.position, newLayer.position) {
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(CGPoint: oldLayer.position)
            animation.toValue = NSValue(CGPoint: newLayer.position)
            animations.append(animation)
        }
        
        if oldLayer.opacity != newLayer.opacity {
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = oldLayer.opacity
            animation.toValue = newLayer.opacity
            animations.append(animation)
        }
        
        if animations.count > 0 {
            animationGroup = CAAnimationGroup()
            animationGroup!.animations = animations
        }
        
        return animationGroup
    }
    
    class func animatableLayerCopy(layer: CALayer) -> CALayer {
        
        let layerCopy = CALayer()
        
        layerCopy.opacity = layer.opacity
        layerCopy.transform = layer.transform
        layerCopy.bounds = layer.bounds
        layerCopy.position = layer.position
        
        return layerCopy
    }
    
    // MARK: - Core Animation Delegate
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let completion = completionClosure {
            completion(finished: true)
        }
    }
}