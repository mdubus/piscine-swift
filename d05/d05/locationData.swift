//
//  locationData.swift
//  d05
//
//  Created by Morgane DUBUS on 3/7/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import MapKit

class Pin: MKPointAnnotation {
    
    init(title:String, subtitle:String, coordinate: CLLocationCoordinate2D ) {
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

let locations : [Pin] = [
    Pin(title: "42", subtitle: "My beautiful school <3", coordinate: CLLocationCoordinate2D(latitude: 48.896928, longitude: 2.318345)),
]
