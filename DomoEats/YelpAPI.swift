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
    private let kConsumerKey = "Bb0PTv3rNSHO3UsXOLVeLw"
    private let kConsumerSecret = "K2qk374K34_7A2XYg-5-RqZLbEc"
    private let kToken = "Fhbd3Iuj4MijQ7y34xgQEPGhQi6ukhpx"
    private let kTokenSecret = "cG2bFeWYDLxX1Q-SQ_qp2kW7yz0"
    static let shared = YelpAPI()
    private var session:NSURLSession!
    private override init() {
        super.init()
        self.session = NSURLSession.sharedSession()
        self.session.configuration.timeoutIntervalForRequest = 10.0
    }
    
    
    func getPlacesAroundUser(lat:Double, long:Double, location:String, completion:(places:[Places], error:NSError?) -> Void) {
        let request = TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term":"food", "cll":"\(lat),\(long)", "location":location], scheme: "https", host: "api.yelp.com", consumerKey: kConsumerKey, consumerSecret: kConsumerSecret, accessToken: kToken, tokenSecret: kTokenSecret)
        setupDataTask(wthRequest: request) { (data, response, error) -> Void in
            if data != nil {
                let json = JSON(data: data!)
                var places = [Places]()
                for business in json["businesses"] {
                    places.append(Places(data: business.1))
                }
                completion(places: places, error: nil)
            } else {
                completion(places: [Places](), error: error)
            }
        }
    }
    
    func search(forLocation location:String, withCategoryFilters filters:[String], completion:(places:[Places], error:NSError?)->Void) {
        let joinedFiltersWithComma = filters.joinWithSeparator(",")
        let request = TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term":"food", "location":location, "category_filter":joinedFiltersWithComma], scheme: "https", host: "api.yelp.com", consumerKey: kConsumerKey, consumerSecret: kConsumerSecret, accessToken: kToken, tokenSecret: kTokenSecret)
        setupDataTask(wthRequest: request) { (data, response, error) -> Void in
            if data != nil {
                let json = JSON(data: data!)
                var places = [Places]()
                for business in json["businesses"] {
                    places.append(Places(data: business.1))
                }
                completion(places: places, error: nil)
            } else {
                completion(places: [Places](), error: error)
            }
        }
    }
    
    func search(withLat lat:String, withLong long:String, filters:[String], completion:(places:[Places], error:NSError?)->Void) {
        let request = TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term":"food", "cll":"\(lat),\(long)", "category_filter":filters.joinWithSeparator(",")], scheme: "https", host: "api.yelp.com", consumerKey: kConsumerKey, consumerSecret: kConsumerSecret, accessToken: kToken, tokenSecret: kTokenSecret)
        setupDataTask(wthRequest: request) { (data, response, error) -> Void in
            if data != nil {
                let json = JSON(data: data!)
                var places = [Places]()
                for business in json["businesses"] {
                    places.append(Places(data: business.1))
                }
                completion(places: places, error: nil)
            } else {
                completion(places: [Places](), error: error)
            }
        }
    }
    
    func search(forLocation location:String, completion:(places:[Places], error:NSError?) -> Void) {
        let request = TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term":"food", "location":location], scheme: "https", host: "api.yelp.com", consumerKey: kConsumerKey, consumerSecret: kConsumerSecret, accessToken: kToken, tokenSecret: kTokenSecret)
        setupDataTask(wthRequest: request) { (data, response, error) -> Void in
            if data != nil {
                let json = JSON(data: data!)
                var places = [Places]()
                for business in json["businesses"] {
                    places.append(Places(data: business.1))
                }
                completion(places: places, error: nil)
            } else {
                completion(places: [Places](), error: error)
            }
        }
        
    }
    
    private func setupDataTask(wthRequest request:NSURLRequest, completion:(data:NSData?, response:NSURLResponse?, error:NSError?)->Void) {
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil {
                if data != nil {
                    completion(data: data, response: response, error: nil)
                } else {
                    completion(data: nil, response: response, error: error)
                }
            } else {
                completion(data: nil, response: response, error: error)
            }
        }
        task.resume()
    }
    
}