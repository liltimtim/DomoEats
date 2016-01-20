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
    
    @IBOutlet weak var placeMapView: MKMapView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var starRatingImage: UIImageView!
    var place:MapPlaces?
    var resolvedPlace:Places?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.placeMapView.mapType = MKMapType.Satellite

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if place != nil && place?.yelpID != nil {
            placeMapView.addAnnotation(place!)

            let region = MKCoordinateRegionMakeWithDistance(place!.coordinate, 500, 500)
            self.placeMapView.setRegion(region, animated: true)
            YelpAPI.shared.getPlace(withYelpID: place!.yelpID!, completion: { (place, error) -> Void in
                if error == nil {
                    self.resolvedPlace = place
                    self.refreshUIView()
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    private func refreshUIView() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.resolvedPlace != nil {
                self.resolvedPlace!.getStarRatingImage({ (image) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.starRatingImage.image = image
                    })
                })
                
                if self.resolvedPlace?.name != nil {
                    self.placeNameLabel.text = "\(self.resolvedPlace!.name!)"
                }
                
//                let region = MKCoordinateRegionMakeWithDistance(self.resolvedPlace!.getCoordinates()!, 500, 500)
//                self.placeMapView.setRegion(region, animated: true)
            }
        })
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
