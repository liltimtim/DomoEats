//
//  Authentication.swift
//  DomoEats
//
//  Created by Timothy Barrett on 12/27/15.
//  Copyright © 2015 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
public class Authentication:NSObject {
    public static let sharedAuth:Authentication = Authentication()
    
    private override init() { }
    
    public func signUp(withEmail email:String, withPassword password:String, withUsername username:String, completion:(success:Bool, error:NSError?)->Void) {
        let user = PFUser()
        user.email = email
        user.password = password
        user.username = username
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            completion(success: success, error: error)
        }
    }
    
    public func auth(withUsername username:String, withPassword password:String, completion:(success:Bool, error:NSError?)->Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            if error == nil {
                if user != nil {
                    completion(success: true, error: nil)
                } else {
                    completion(success: false, error: NSError(domain: "Authentication", code: 0, userInfo: ["error":"User was nil"]))
                }
            } else {
                completion(success: false, error: error)
            }
        }
    }
}