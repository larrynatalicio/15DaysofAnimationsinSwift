//
//  ViewController.swift
//  GifAnimation
//
//  Created by Larry Natalicio on 4/30/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Types
    
    struct Constants {
        struct Gifs {
            static let catVideo = "cat-video.gif"
        }
    }
    
    // MARK: - Properties

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Status Bar

    override var prefersStatusBarHidden : Bool {
        return true
    }
}

