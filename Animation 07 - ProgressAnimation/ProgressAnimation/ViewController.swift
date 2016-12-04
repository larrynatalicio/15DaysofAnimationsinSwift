//
//  ViewController.swift
//  ProgressAnimation
//
//  Created by Larry Natalicio on 4/22/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var progressView: ProgressView!
    @IBOutlet var progressPercentageLabel: UILabel!
    @IBOutlet var incrementProgressButton: UIButton!
    
    let gallon = Gallon()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureProgressView()
    }
    
    // MARK: - IBActions

    @IBAction func incrementProgress(_ sender: UIButton) {
        
        guard progressView.curValue < CGFloat(gallon.totalOunces) else {
            return
        }
        
        // Increment progressView curValue.
        let eightOunceCup = 8
        progressView.curValue = progressView.curValue + CGFloat(eightOunceCup)
        
        // Update label based on progressView curValue.
        let percentage = (Double(progressView.curValue) / Double(gallon.totalOunces))
        progressPercentageLabel.text = numberAsPercentage(percentage)
    }
    
    // MARK: - Convenience
    
    func configureProgressView() {
        progressView.curValue = CGFloat(gallon.ouncesDrank)
        progressView.range = CGFloat(gallon.totalOunces)
    }
    
    func numberAsPercentage(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = ""
        return formatter.string(from: NSNumber(value: number))!
    }
    
    // MARK: - Status Bar
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

}

