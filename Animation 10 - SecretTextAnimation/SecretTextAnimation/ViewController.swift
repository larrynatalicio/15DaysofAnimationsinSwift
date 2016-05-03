//
//  ViewController.swift
//  SecretTextAnimation
//
//  Created by Larry Natalicio on 4/27/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Types
    
    struct Constants {
        struct Images {
            static let one = "one"
            static let two = "two"
            static let three = "three"
            static let four = "four"
            static let five = "five"
            static let six = "six"
            static let seven = "seven"
            static let eight = "eight"
            static let nine = "nine"
            static let ten = "ten"
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    var quoteLabel: FadingLabel!
    let animationDuration: NSTimeInterval = 1.0
    let switchingInterval: NSTimeInterval = 3.0
    var currentIndex = 0
    
    let quotes = [
        Quote(quote: "\"The unexamined life is not worth living.\"", author: "Socrates", image: UIImage(named: Constants.Images.one)!),
        Quote(quote: "\"The most beautiful thing we can experience is the mysterious. It is the source of all true art and science.\"", author: "Albert Einstein", image: UIImage(named: Constants.Images.two)!),
        Quote(quote: "\"I do not steal victory.\"", author: "Alexander the Great", image: UIImage(named: Constants.Images.three)!),
        Quote(quote: "\"The key to immortality is first living a life worth remembering.\"", author: "Bruce Lee", image: UIImage(named: Constants.Images.four)!),
        Quote(quote: "\"Decide... whether or not the goal is worth the risks involved. If it is, stop worrying....\"", author: "Amelia Earhart", image: UIImage(named: Constants.Images.five)!),
        Quote(quote: "\"I've failed over and over and over again in my life and that is why I succeed.\"", author: "Michael Jordan", image: UIImage(named: Constants.Images.six)!),
        Quote(quote: "\"Kind words can be short and easy to speak, but their echoes are truly endless.\"", author: "Mother Teresa", image: UIImage(named: Constants.Images.seven)!),
        Quote(quote: "\"Live as if you were to die tomorrow; learn as if you were to live forever.\"", author: "Mahatma Gandhi", image: UIImage(named: Constants.Images.eight)!),
        Quote(quote: "\"Somewhere, something incredible is waiting to be known.\"", author: "Carl Sagan", image: UIImage(named: Constants.Images.nine)!),
        Quote(quote: "\"It is not death that a man should fear, but he should fear never beginning to live.\"", author: "Marcus Aurelius", image: UIImage(named: Constants.Images.ten)!),
        ]

    // MARK: - View Life Cycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCharacterLabel()
        setupBackgroundImageView()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateBackgroundImageView()
    }
    
    // MARK: - Convenience
    
    func animateBackgroundImageView() {
        
        // Quote is switched here so it is in sync with the image switching.
        switchQuote()
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.animateBackgroundImageView()
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        
        
        backgroundImageView.layer.addAnimation(transition, forKey: kCATransition)
        backgroundImageView.image = quotes[currentIndex].image
        
        CATransaction.commit()
        
        // Increase index to switch both the quote and image to the next.
        currentIndex = currentIndex < quotes.count - 1 ? currentIndex + 1 : 0
    }
    
    func switchQuote() {
        quoteLabel.text = "" // Clear label before switching to a new quote.
        quoteLabel.text = quotes[currentIndex].quote + "\n\n" + quotes[currentIndex].author
    }
    
    func setupBackgroundImageView() {
        // Initial image.
        backgroundImageView.image = quotes[currentIndex].image
    }

    func setupCharacterLabel() {
        quoteLabel = FadingLabel(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.textAlignment = NSTextAlignment.Center
        quoteLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        quoteLabel.textColor = UIColor.whiteColor()
        quoteLabel.lineBreakMode = .ByWordWrapping
        quoteLabel.numberOfLines = 0
        
        self.view.addSubview(quoteLabel)
        
        // Constraints.
        NSLayoutConstraint.activateConstraints([
            quoteLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor),
            quoteLabel.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor),
            quoteLabel.widthAnchor.constraintEqualToConstant(self.view.frame.width / 1.25)
            ])
    }
    
    // MARK: - Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

