//
//  Model.swift
//  d07
//
//  Created by Kevin VIGNAU on 10/10/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import Foundation

struct Location {
    let lat: Double
    let lng: Double
    
//    init(lat: Double, lng: Double) {
//        self.lat = lat
//        self.lng = lng
//    }
    init(location: NSDictionary) {
        self.lat = location["lat"] as! Double
        self.lng = location["lng"] as! Double
    }
}
