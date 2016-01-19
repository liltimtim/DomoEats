//
//  PlaceDetailViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/19/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
import MapKit
class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    var place:MapPlaces?
    var resolvedPlace:Places?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if place != nil && place?.yelpID != nil {
            YelpAPI.shared.getPlace(withYelpID: place!.yelpID!, completion: { (place, error) -> Void in
                if error == nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.resolvedPlace = place
                        self.placeNameLabel.text = "Place Name: \(place?.name)"
                    })
                } else {
                    // TODO: Display resolving place error.
                }
                
            })
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
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
