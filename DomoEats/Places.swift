//
//  Places.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/2/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import SwiftyJSON
class Places:NSObject {
    private(set) var yelpID:String?
    private(set) var name:String?
    private(set) var imageURL:String?
    private(set) var url:String?
    private(set) var starRatingURL:String?
    private(set) var location:[String]?
    private(set) var categories:[String] = [String]()

    init(data:JSON) {
        yelpID = data["id"].string
        name = data["name"].string
        imageURL = data["snippet_image_url"].string
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
    }
    
    func getStarRatingImage(completion:(image:UIImage?)->Void) {
        
    }
}