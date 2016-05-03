//
//  LockViewController.swift
//  LockScreenAnimation
//
//  Created by Larry Natalicio on 4/16/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class LockViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var topLock: UIImageView!
    @IBOutlet var bottomLock: UIImageView!
    @IBOutlet var lockBorder: UIImageView!
    @IBOutlet var lockKeyhole: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        openLock()
    }
    
    // MARK: Convenience
    
    func openLock() {
        UIView.animateWithDuration(0.4, delay: 5.0, options: [], animations: {
            
            // Rotate keyhole.
            self.lockKeyhole.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            
            }, completion: { _ in
                UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
                    
                    // Open lock.
                    let yDelta = self.lockBorder.frame.maxY
                    
                    self.topLock.center.y -= yDelta
                    self.lockKeyhole.center.y -= yDelta
                    self.lockBorder.center.y -= yDelta
                    self.bottomLock.center.y += yDelta
                    }, completion: { _ in
                        self.topLock.removeFromSuperview()
                        self.lockKeyhole.removeFromSuperview()
                        self.lockBorder.removeFromSuperview()
                        self.bottomLock.removeFromSuperview()
                })
        })
    }
    
    // MARK: - Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
