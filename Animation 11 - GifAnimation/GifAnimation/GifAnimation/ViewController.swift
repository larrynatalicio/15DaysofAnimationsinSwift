//
//  ViewController.swift
//  GifAnimation
//
//  Created by Larry Natalicio on 4/30/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit
import Gifu

class ViewController: UIViewController {
    
    // MARK: - Types
    
    struct Constants {
        struct Gifs {
            static let catVideo = "cat-video.gif"
        }
    }
    
    // MARK: - Properties

    @IBOutlet var gifImageView: AnimatableImageView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Use third-party library `Gifu` to display gif.
        */
        gifImageView.animateWithImage(named: Constants.Gifs.catVideo)
    }
    
    // MARK: - Status Bar

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

