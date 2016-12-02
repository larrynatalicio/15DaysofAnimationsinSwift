//
//  LoadingDots.swift
//  LoadingDotsAnimation
//
//  Created by Larry Natalicio on 4/19/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

@IBDesignable
class LoadingDots: UIView {
    
    // MARK: - Properties
    
    @IBOutlet var view: UIView!
    @IBOutlet var dotOne: UIImageView!
    @IBOutlet var dotTwo: UIImageView!
    @IBOutlet var dotThree: UIImageView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNib()
        startAnimation()
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupNib()
        startAnimation()
    }
    
    // MARK: - Nib Loading
    
    func setupNib() {
        self.view = loadNib()
        self.view.frame = self.bounds
        
        // Listen for UIApplicationDidBecomeActiveNotification notification to resume
        // animation when the app returns from the background.
        registerForNotifications()
        
        self.addSubview(self.view)
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
    
    // MARK: - Lifetime
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Convenience
    
    func startAnimation() {
        
        // Make dots very small (practically invsisble) since
        // we want the animation to start from small to big.
        dotOne.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotTwo.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotThree.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.dotOne.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.dotTwo.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.dotThree.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    // MARK: - Notifications
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        startAnimation()
    }
    
}
