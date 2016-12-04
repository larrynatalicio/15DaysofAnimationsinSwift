//
//  ViewController.swift
//  UnderlineAnimation
//
//  Created by Larry Natalicio on 4/20/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    // MARK: - Types
    
    struct Constants {
        struct ConstraintIdentifiers {
            static let centerLeftConstraintIdentifier = "centerLeftConstraintIdentifier"
            static let centerRightConstraintIdentifier = "centerRightConstraintIdentifier"
            static let widthConstraintIdentifier = "widthConstraintIdentifier"
        }
        
        struct ColorPalette {
            static let green = UIColor(red:0.00, green:0.87, blue:0.71, alpha:1.0)
        }
    }
    
    enum Side {
        case left
        case right
    }
    
    // MARK: - Properties
    
    @IBOutlet var optionsBar: UIStackView!
    
    var underlineView: Underline!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUnderlineView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /* 
        The frame is not correct when I call (optionsBar.frame.width / 2) in viewWillAppear.
        Therefore, I update the width constraint to this here.
        This also updates the constraint when the view rotates.
        */
        for constraint in underlineView.constraints {
            if constraint.identifier == Constants.ConstraintIdentifiers.widthConstraintIdentifier {
                constraint.constant = (optionsBar.frame.width / 2.5)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func goLeft(_ sender: UIButton) {
        
        animateContraintsForUnderlineView(underlineView, toSide: .left)
    }
    
    @IBAction func goRight(_ sender: UIButton) {
        
        animateContraintsForUnderlineView(underlineView, toSide: .right)
    }
    
    // MARK: - Convenience
    
    func setupUnderlineView() {
        underlineView = Underline()
        self.view.addSubview(underlineView)
        
        let topConstraint = underlineView.topAnchor.constraint(equalTo: optionsBar.bottomAnchor)
        let heightConstraint = underlineView.heightAnchor.constraint(equalToConstant: 2)
        
        let leftButton = optionsBar.arrangedSubviews[0]
        let centerLeftConstraint = underlineView.centerXAnchor.constraint(equalTo: leftButton.centerXAnchor)
        centerLeftConstraint.identifier = Constants.ConstraintIdentifiers.centerLeftConstraintIdentifier
        
        // The frame is not set here correctly so I update this value again in viewDidLayoutSubviews.
        let widthConstraint = underlineView.widthAnchor.constraint(equalToConstant: (optionsBar.frame.width / 2.5))
        widthConstraint.identifier = Constants.ConstraintIdentifiers.widthConstraintIdentifier
        
        NSLayoutConstraint.activate([topConstraint, heightConstraint, widthConstraint, centerLeftConstraint])
    }
    
    func animateContraintsForUnderlineView(_ underlineView: UIView, toSide: Side) {
        
        switch toSide {
        case .left:
            
            for constraint in underlineView.superview!.constraints {
                if constraint.identifier == Constants.ConstraintIdentifiers.centerRightConstraintIdentifier {
                    
                    constraint.isActive = false
                    
                    let leftButton = optionsBar.arrangedSubviews[0]
                    let centerLeftConstraint = underlineView.centerXAnchor.constraint(equalTo: leftButton.centerXAnchor)
                    centerLeftConstraint.identifier = Constants.ConstraintIdentifiers.centerLeftConstraintIdentifier
                    
                    NSLayoutConstraint.activate([centerLeftConstraint])
                }
            }
            
        case .right:
            
            for constraint in underlineView.superview!.constraints {
                if constraint.identifier == Constants.ConstraintIdentifiers.centerLeftConstraintIdentifier {
                    
                    constraint.isActive = false
                    
                    let rightButton = optionsBar.arrangedSubviews[1]
                    let centerRightConstraint = underlineView.centerXAnchor.constraint(equalTo: rightButton.centerXAnchor)
                    centerRightConstraint.identifier = Constants.ConstraintIdentifiers.centerRightConstraintIdentifier
                    
                    NSLayoutConstraint.activate([centerRightConstraint])
                    
                }
            }
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.ColorPalette.green
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
}

