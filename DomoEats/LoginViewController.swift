//
//  LoginViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 12/27/15.
//  Copyright © 2015 Timothy Barrett. All rights reserved.
//

import UIKit
import QuartzCore
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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


    @IBAction func loginPressed(sender: AnyObject) {
        validateTextFields()

    }
    @IBAction func signupPressed(sender: AnyObject) {
        // user doesn't have an account present signup screen
        if let _:SignUpViewController = storyboard?.instantiateViewControllerWithIdentifier("signupView") as? SignUpViewController {
            self.performSegueWithIdentifier("showSignUp", sender: nil)
        }
    }
    
    func validateTextFields() {
        if emailTextField.text!.isEmpty {
            AnimationShakeTextField(emailTextField)
        }
        
        if passwordTextField.text!.isEmpty {
            AnimationShakeTextField(passwordTextField)
        }
    }
    
    func AnimationShakeTextField(textField:UITextField){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 5, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 5, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
