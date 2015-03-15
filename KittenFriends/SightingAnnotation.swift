//
//  SightingAnnotation.swift
//  KittenFriends
//
//  Created by Mark Pleskac on 3/15/15.
//  Copyright (c) 2015 Mark Pleskac. All rights reserved.
//

import Foundation
import MapKit

class SightingAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = ""
        self.subtitle = ""
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate;
    }
}