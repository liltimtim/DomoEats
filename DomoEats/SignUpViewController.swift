//
//  SignUpViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 12/27/15.
//  Copyright © 2015 Timothy Barrett. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func existingAccountPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("showLogin", sender: nil)
    }
    @IBAction func signupPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func validate() -> Bool {
        if let email:UITextField = emailField {
            if email.text!.isEmpty {
                return false
            }
        }
        
        if passwordField!.text!.isEmpty {
            return false
        }
        
        if confirmPasswordField.text!.isEmpty {
            return false
        }
        
        if passwordField.text! != confirmPasswordField.text! {
            return false
        }
        return true
    }

}
