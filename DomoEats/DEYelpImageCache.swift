//
//  DEYelpImageCache.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/3/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import UIKit
class DEYelpImageCache:NSObject {
    private let cache:NSCache = NSCache()
    static let shared:DEYelpImageCache = DEYelpImageCache()
    
    private override init() { }
    
    func addImage(image:UIImage, key:String) {
        cache.setObject(image, forKey: key)
    }
    
    func getImage(key:String) -> UIImage? {
        if let image:UIImage = cache.objectForKey(key) as? UIImage {
            return image
        } else {
            return nil
        }
    }
}