//
//  Annotation.swift
//  MapLocationAnimation
//
//  Created by Larry Natalicio on 4/17/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    // MARK: - Properties

    let coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    // MARK: - Initializers
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

}
