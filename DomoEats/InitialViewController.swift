//
//  InitialViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/2/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchCityField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activityIndicator.hidden = true
        searchCityField.attributedPlaceholder = NSAttributedString(string: "Enter city name", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapGesture)
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
    
    @IBAction func searchPressed(sender: AnyObject) {
        if validateTextFields() {
            searchBtn.setTitle("", forState: UIControlState.Normal)
            activityIndicator.hidden = false
            activityIndicator.startAnimating()
            YelpAPI.shared.search(forLocation: searchCityField.text!, completion: { (places, error) -> Void in
                if error == nil {
                    if places.count > 0 {
                        print("did receive multiple places")
                    } else {
                        self.displayError("I could not find any results matching that city. Please check your spelling and try again or enter a different city")
                    }
                } else {
                    self.displayError(error!.localizedDescription)
                }
            })
        } else {
            displayError("You cannot have an empty city name!")
        }
        
    }
    
    private func displayError(message:String) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            self.searchBtn.setTitle("Search", forState: UIControlState.Normal)
            
            // error fetching results
            let alertView = UIAlertController(title: "Results not found", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
            alertView.addAction(okayAction)
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
    
    private func validateTextFields() -> Bool {
        if searchCityField.text?.characters.count > 0 && searchCityField.text != nil {
            return true
        }
        return false
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
