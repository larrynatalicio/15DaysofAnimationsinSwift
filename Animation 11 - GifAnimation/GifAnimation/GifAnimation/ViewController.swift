//
//  ViewController.swift
//  GifAnimation
//
//  Created by Larry Natalicio on 4/30/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class ViewController: UIViewController {
    
    // MARK: - Types
    
    struct Constants {
        struct Gifs {
            static let catVideo = "cat-video"
        }
    }
    
    // MARK: - Properties

    @IBOutlet weak var gifImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Use third-party library `SwiftGif` to display gif.
         */
        gifImageView.loadGif(name: Constants.Gifs.catVideo)
    }
    
    // MARK: - Status Bar

    override var prefersStatusBarHidden : Bool {
        return true
    }
}

