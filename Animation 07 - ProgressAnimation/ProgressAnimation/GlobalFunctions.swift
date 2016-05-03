//
//  GlobalFunctions.swift
//  ProgressAnimation
//
//  Created by Larry Natalicio on 4/22/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
