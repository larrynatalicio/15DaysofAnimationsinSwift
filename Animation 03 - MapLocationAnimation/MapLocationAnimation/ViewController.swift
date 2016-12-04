//
//  ViewController.swift
//  MapLocationAnimation
//
//  Created by Larry Natalicio on 4/17/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Types
    
    struct Constants {
        struct MapViewIdentifiers {
            static let sonarAnnotationView = "sonarAnnotationView"
        }
    }
    
    // MARK: - Properties

    @IBOutlet var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 3000
    let latitude = 40.758873
    let longitude = -73.985134
    
    // MARK: - View Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set initial location for map view.
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(initialLocation)
        
        // Add annotation to map based on location.
        let annotation = Annotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: nil, subtitle: nil)
        mapView.addAnnotation(annotation)
    }

   // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        // Reuse the annotation if possible.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.MapViewIdentifiers.sonarAnnotationView)
        
        if annotationView == nil {
           annotationView = SonarAnnotationView(annotation: annotation, reuseIdentifier: Constants.MapViewIdentifiers.sonarAnnotationView)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    // MARK: - Convenience
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    // MARK: - Status Bar
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}


