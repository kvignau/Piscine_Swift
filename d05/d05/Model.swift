//
//  Model.swift
//  d05
//
//  Created by Kevin VIGNAU on 10/8/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import Foundation
import MapKit


struct Place {
    let name: String
    let location: CLLocationCoordinate2D
    let region: MKCoordinateRegion
    let span: MKCoordinateSpan
    let annotation = MKPointAnnotation()
    
    init(name: String, location: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        self.name = name
        self.location = location
        self.region = MKCoordinateRegion(center: location, span: span)
        self.span = span
        self.annotation.coordinate = location
        self.annotation.title = name
        self.annotation.subtitle = name
    }
    
    init(name: String, location: CLLocationCoordinate2D, span: MKCoordinateSpan, subtitle: String) {
        self.name = name
        self.location = location
        self.region = MKCoordinateRegion(center: location, span: span)
        self.span = span
        self.annotation.coordinate = location
        self.annotation.title = name
        self.annotation.subtitle = subtitle
    }
}
