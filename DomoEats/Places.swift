//
//  Places.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/2/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit
class Places:NSObject {
    private(set) var yelpID:String?
    private(set) var name:String?
    private(set) var imageURL:String?
    private(set) var url:String?
    private(set) var starRatingURL:String?
    private(set) var location:[String]?
    private(set) var categories:[String] = [String]()
    private(set) var latitude:Double?
    private(set) var long:Double?

    init(data:JSON) {
        yelpID = data["id"].string
        name = data["name"].string
        imageURL = data["image_url"].string
        url = data["url"].string
        for addressItem in data["display_address"] {
            location?.append(addressItem.0)
        }
        // parse the category for an item
        for category in data["categories"] {
            for item in category.1 {
                if item.1.string != nil {
                    categories.append(item.1.string!)
                }
            }
        }
        starRatingURL = data["rating_img_url_large"].string
        
        //location.coordinate.latitude
        latitude = data["location"]["coordinate"]["latitude"].double
        long = data["location"]["coordinate"]["longitude"].double
    }
    
    func getStarRatingImage(completion:(image:UIImage?)->Void) {
        
    }
    
    func getBusinessImage(completion:(image:UIImage?)->Void) {
        // first check the cache to see if an image exists or not
        if imageURL != nil {
            if let returnedImage = DEYelpImageCache.shared.getImage(imageURL!) {
                completion(image: returnedImage)
            } else {
                // no image in cache grab from network add it to cache
                
            }
        }
        
    }
    
    func getFriendlyCategories() -> [String] {
        var friendly = [String]()
        for var i = 0; i < categories.count; i+=2 {
            friendly.append(categories[i])
        }
        return friendly
    }
    
    func getCoordinates() -> CLLocationCoordinate2D? {
        if latitude != nil && long != nil {
            return CLLocationCoordinate2D(latitude: latitude!, longitude: long!)
        }
        return nil
    }
}