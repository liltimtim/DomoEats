//
//  MapPlaces.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/3/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import MapKit

class MapPlaces:NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var yelpID: String?
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, yelpID:String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.yelpID = yelpID
    }
    
}