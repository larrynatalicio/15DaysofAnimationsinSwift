//
//  PullRefreshView.swift
//  PullToRefreshAnimation
//
//  Created by Larry Natalicio on 4/25/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

// Pull Refresh View Delegate Protocol
protocol PullRefreshViewDelegate {
    func PullRefreshViewDidRefresh(PullRefreshView: PullRefreshView)
}

@IBDesignable
class PullRefreshView: UIView {
    
    // MARK: - Properties
    var delegate: PullRefreshViewDelegate?
    var scrollView: UIScrollView?
    var refreshing: Bool = false
    var progress: CGFloat = 0.0
    var isRefreshing = false
    let flyingSaucerLayer = CALayer()
    var paths = [UIBezierPath]()
    
    
    // MARK: - Initializers
    init(frame: CGRect, scrollView: UIScrollView) {
        super.init(frame: frame)
        
        self.scrollView = scrollView
        
        // Add the background image.
        let pullRefreshBackgroundImageView = UIImageView(image: UIImage(image: .PullRefreshViewBackground))
        pullRefreshBackgroundImageView.frame = bounds
        pullRefreshBackgroundImageView.contentMode = .ScaleAspectFill
        pullRefreshBackgroundImageView.clipsToBounds = true
        addSubview(pullRefreshBackgroundImageView)
        
        // Create custom paths for flying-saucer to animate on.
        paths = customPaths(frame: CGRect(x: 20, y: self.bounds.height / 5, width: self.bounds.width / 1.8, height: self.bounds.height / 1.5))
        
        // Add flying saucer image.
        guard let flyingSaucerImage = UIImage(image: .FlyingSaucer) else { return }
        flyingSaucerLayer.contents = flyingSaucerImage.CGImage
        flyingSaucerLayer.bounds = CGRect(x: 0.0, y: 0.0, width: flyingSaucerImage.size.width, height: flyingSaucerImage.size.height)
        let enterPath = paths[0]
        flyingSaucerLayer.position = enterPath.firstPoint()! // It's initial position will be at the first point of the path.
        
        layer.addSublayer(flyingSaucerLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    // MARK: - Convenience
    
    func beginRefreshing() {
        isRefreshing = true
        
        UIView.animateWithDuration(0.3, animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView!.contentInset = newInsets
        })
        
        /* PART 2 HOVER ANIMATION */
        
        let hoverAnimation = CABasicAnimation(keyPath: "position")
        hoverAnimation.additive = true
        hoverAnimation.fromValue = NSValue(CGPoint: CGPointZero)
        hoverAnimation.toValue = NSValue(CGPoint: CGPointMake(0.0, 50.0))
        hoverAnimation.autoreverses = true
        hoverAnimation.duration = 0.7
        hoverAnimation.repeatCount = 2
        hoverAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        hoverAnimation.removedOnCompletion = false
        hoverAnimation.fillMode = kCAFillModeForwards
        
        flyingSaucerLayer.addAnimation(hoverAnimation, forKey: nil)
        let enterPath = paths[0]
        flyingSaucerLayer.position = enterPath.currentPoint
        
    }
    
    func endRefreshing() {
        
        self.isRefreshing = false

        UIView.animateWithDuration(0.3, delay:0.2, options: .CurveEaseOut ,animations: {

            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView!.contentInset = newInsets
            }, completion: { _ in
                //finished
        })
        
        /* PART 3 EXIT ANIMATION */
        
        let exitPath = paths[1]
        
        // Animate image along exit path.
        let exitPathAnimation = CAKeyframeAnimation(keyPath: "position")
        exitPathAnimation.path = exitPath.CGPath
        exitPathAnimation.calculationMode = kCAAnimationPaced
        exitPathAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        exitPathAnimation.beginTime = CFTimeInterval()
        exitPathAnimation.duration = 0.3
        exitPathAnimation.removedOnCompletion = true
        exitPathAnimation.fillMode = kCAFillModeForwards
        
        flyingSaucerLayer.addAnimation(exitPathAnimation, forKey: nil)
        
        // Animate size along exit path.
        let sizeAlongExitPathAnimation = CABasicAnimation(keyPath: "transform.scale")
        sizeAlongExitPathAnimation.fromValue = 1
        sizeAlongExitPathAnimation.toValue = 0
        sizeAlongExitPathAnimation.duration = 0.3
        sizeAlongExitPathAnimation.beginTime = CFTimeInterval()
        sizeAlongExitPathAnimation.removedOnCompletion = true
        sizeAlongExitPathAnimation.fillMode = kCAFillModeForwards
        
        flyingSaucerLayer.addAnimation(sizeAlongExitPathAnimation, forKey: nil)

    }
    
    func redrawFromProgress(progress: CGFloat) {
        
        /* PART 1 ENTER ANIMATION */
        
        let enterPath = paths[0]

        // Animate image along enter path.
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = enterPath.CGPath
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        pathAnimation.beginTime = 1e-100
        pathAnimation.duration = 1.0
        pathAnimation.timeOffset = CFTimeInterval() + Double(progress)
        pathAnimation.removedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        
        flyingSaucerLayer.addAnimation(pathAnimation, forKey: nil)
        flyingSaucerLayer.position = enterPath.currentPoint
        
        // Animate size along enter path.
        let sizeAlongEnterPathAnimation = CABasicAnimation(keyPath: "transform.scale")
        sizeAlongEnterPathAnimation.fromValue = 0
        sizeAlongEnterPathAnimation.toValue = progress
        sizeAlongEnterPathAnimation.beginTime = 1e-100
        sizeAlongEnterPathAnimation.duration = 1.0
        sizeAlongEnterPathAnimation.removedOnCompletion = false
        sizeAlongEnterPathAnimation.fillMode = kCAFillModeForwards
        
        flyingSaucerLayer.addAnimation(sizeAlongEnterPathAnimation, forKey: nil)

    }
    
    func customPaths(frame frame: CGRect = CGRectMake(4, 3, 166, 74)) -> [UIBezierPath] {
       
        // 2 different paths returned: Enter and Exit.
        
        let enterPath = UIBezierPath()
        enterPath.moveToPoint(CGPointMake(frame.minX + 0.08146 * frame.width, frame.minY + 0.09459 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.03076 * frame.width, frame.minY + 0.26040 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.08146 * frame.width, frame.minY + 0.09459 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.03814 * frame.width, frame.minY + 0.17848 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.03169 * frame.width, frame.minY + 0.48077 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02980 * frame.width, frame.minY + 0.27114 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01776 * frame.width, frame.minY + 0.31165 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.21694 * frame.width, frame.minY + 0.85855 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04828 * frame.width, frame.minY + 0.68225 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.21694 * frame.width, frame.minY + 0.85855 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.36994 * frame.width, frame.minY + 0.92990 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.21694 * frame.width, frame.minY + 0.85855 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33123 * frame.width, frame.minY + 0.93830 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.41416 * frame.width, frame.minY + 0.92165 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.40865 * frame.width, frame.minY + 0.92151 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.39224 * frame.width, frame.minY + 0.92548 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.48146 * frame.width, frame.minY + 0.90262 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43661 * frame.width, frame.minY + 0.91773 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.46286 * frame.width, frame.minY + 0.91204 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.73584 * frame.width, frame.minY + 0.61929 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55989 * frame.width, frame.minY + 0.86290 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68159 * frame.width, frame.minY + 0.72568 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.89621 * frame.width, frame.minY + 0.34225 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75763 * frame.width, frame.minY + 0.57655 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83515 * frame.width, frame.minY + 0.45666 * frame.height))
        enterPath.addCurveToPoint(CGPointMake(frame.minX + 0.98193 * frame.width, frame.minY + 0.15336 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.93621 * frame.width, frame.minY + 0.26730 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.96431 * frame.width, frame.minY + 0.19090 * frame.height))
        enterPath.miterLimit = 4
        enterPath.usesEvenOddFillRule = true
        
        let exitPath = UIBezierPath()
        exitPath.moveToPoint(CGPointMake(frame.minX + 0.98193 * frame.width, frame.minY + 0.15336 * frame.height))
        exitPath.addLineToPoint(CGPointMake(frame.minX + 0.51372 * frame.width, frame.minY + 0.28558 * frame.height))
        exitPath.addCurveToPoint(CGPointMake(frame.minX + 0.47040 * frame.width, frame.minY + 0.25830 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.51372 * frame.width, frame.minY + 0.28558 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.47685 * frame.width, frame.minY + 0.29556 * frame.height))
        exitPath.miterLimit = 4
        exitPath.usesEvenOddFillRule = true
        
        return [enterPath, exitPath]
    }
}

extension PullRefreshView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = CGFloat(max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
        self.progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
        
        if !isRefreshing {
            redrawFromProgress(self.progress)
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.PullRefreshViewDidRefresh(self)
            beginRefreshing()
        }
    }

}

