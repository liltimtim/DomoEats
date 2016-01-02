//
//  YelpAPI.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/1/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import TDOAuth
import SwiftyJSON
class YelpAPI:NSObject {
    static let kConsumerKey = "Bb0PTv3rNSHO3UsXOLVeLw"
    static let kConsumerSecret = "K2qk374K34_7A2XYg-5-RqZLbEc"
    static let kToken = "Fhbd3Iuj4MijQ7y34xgQEPGhQi6ukhpx"
    static let kTokenSecret = "cG2bFeWYDLxX1Q-SQ_qp2kW7yz0"
    static let shared = YelpAPI()
    private var session:NSURLSession!
    private override init() {
        super.init()
        self.session = NSURLSession.sharedSession()
        self.session.configuration.timeoutIntervalForRequest = 10.0
    }
    
    func search(completion:(success:Bool) -> Void) {
        let request = requestWithHost("", params: ["hello":"world"], host: "")
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            print(response)
            let json = JSON(data: data!)
            print(json["businesses"].count)
            print(json["businesses"][0])
            completion(success: true)
        }
        task.resume()
    }
    
    func getPlacesAroundUser(completion:(success:Bool) -> Void) {
        
    }
    
    private func requestWithHost(path:String, params:[NSObject : AnyObject], host:String) -> NSURLRequest {
        return TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term":"food", "location":"North Augusta"], scheme: "https", host: "api.yelp.com", consumerKey: YelpAPI.kConsumerKey, consumerSecret: YelpAPI.kConsumerSecret, accessToken: YelpAPI.kToken, tokenSecret: YelpAPI.kTokenSecret)
    }
    
}