//
//  SplashViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 12/27/15.
//  Copyright © 2015 Timothy Barrett. All rights reserved.
//
//  This view switches between 3 types of logic.
//  1. Displaying the login Screen
//  2. Displaying the signup Screen
//  3. Dispaying the main application if user has already logged in

import UIKit
import Parse
class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // check if user is authenticated and jump into the main application
        if PFUser.currentUser() != nil {
            // already logged in
            print("user already logged in showing main app")
//            storyboard?.instantiateViewControllerWithIdentifier("show")
        } else {
            // show login screen
            print("user not logged in show login screen")
            weak var loginScreen = storyboard?.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
            self.presentViewController(loginScreen!, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
