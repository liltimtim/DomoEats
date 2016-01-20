//
//  FindViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/3/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
import MapKit
class FindViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    var locationManager:CLLocationManager!
    var searchActivityIndicator:UIActivityIndicatorView?
    private var annotations:[MKAnnotation] = [MKAnnotation]()
    private var places:[Places] = [Places]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // prime user to allow location services to be turned on
        mapView.delegate = self
        searchBar.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        showUserPlaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        mapView.removeAnnotations(annotations)
        annotations.removeAll() // clear out memory for annotations
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(sender)
        print(segue.destinationViewController)
        if let destinationView:PlaceDetailViewController = segue.destinationViewController as? PlaceDetailViewController {
            if let mapViewPlace:MapPlaces = sender as? MapPlaces {
                destinationView.place = mapViewPlace
            }
        }
    }

    
    @IBAction func findMePressed(sender: AnyObject) {
        // prime the user to allow location
//        locationManager.requestWhenInUseAuthorization()
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000, 2000)
        mapView.setRegion(region, animated: true)
    }

    @IBAction func searchPressed(sender: AnyObject) {
        // perform search of businesses around the user
        showUserPlaces()
    }
    
    // MARK: - Location Manager
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print(status.rawValue)
        switch (status) {
        case .AuthorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .Denied:
            print("access to gps denied")
            let locationAlertView = UIAlertController(title: "DomoEats", message: "We do not have permission to determine your location", preferredStyle: UIAlertControllerStyle.Alert)
            let OpenSettionsAction = UIAlertAction(title: "Open Settings", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                // will cause kernal errors if not opened on main thread for some reason
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                })
            })
            let dismissAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                locationAlertView.dismissViewControllerAnimated(true, completion: nil)
            })
            locationAlertView.addAction(dismissAction)
            locationAlertView.addAction(OpenSettionsAction)
            self.presentViewController(locationAlertView, animated: true, completion: nil)
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
        // TODO: Display Error to user that we can't find their location!
        print(manager)
        print(error)
        if error.domain == kCLErrorDomain {
            switch (error.code) {
            case CLError.Denied.rawValue:
                manager.stopUpdatingLocation() // user denied us, stop waisting battery power
                // TODO: Alert the user that they need to share their location if the app is to work properly.
                break
                
            case CLError.LocationUnknown.rawValue:
                // TODO: Alert the user that we are having trouble determining location
                break
                
            default:
                break
            }
        }
    }
    
    // MARK: - Map View Delegate
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let note = view.annotation as? MapPlaces {
            print(note.yelpID)
            print(note.title)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(view)
        print(view.annotation?.title)
        self.performSegueWithIdentifier("showPlaceDetail", sender: view.annotation)
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // I don't need the user's location anymore since I have it
                let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000, 2000)
                self.mapView.setRegion(region, animated: true)
                self.locationManager.stopUpdatingLocation()
                // TODO: Option, I could begin searching the yelp api GeoCoord now since I have the users location?
                // this would allow me to autoload suggested places without the user having to touch anything.
            })
            return nil
        }
        
        let reuseId = "places_pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - Data display refersh
    func refreshDataPoints(places:[Places]) {
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        for place in places {
            if let coordinates:CLLocationCoordinate2D = place.getCoordinates() {
                let newAnnotation = MapPlaces(coordinate: coordinates, title: place.name, subtitle: place.location?[0], yelpID: place.yelpID)
                annotations.append(newAnnotation)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    func showUserPlaces() {
        if places.count != 0 {
            refreshDataPoints(places)
        } else {
            if mapView.userLocation.location != nil {
                CLGeocoder().reverseGeocodeLocation(mapView.userLocation.location!) { (placeMarks, error) -> Void in
                    if error == nil {
                        if placeMarks?.count > 0 {
                            if let pm:CLPlacemark = placeMarks?[0] {
                                if let locality:String = pm.locality {
                                    YelpAPI.shared.getPlacesAroundUser(self.mapView.userLocation.location!.coordinate.latitude, long: self.mapView.userLocation.location!.coordinate.longitude, location: locality, completion: { (places, error) -> Void in
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            self.places = places
                                            self.refreshDataPoints(places)
                                        })
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Search Bar Delegates
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search clicked")
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActivityIndicator = UIActivityIndicatorView()
        searchBar.addSubview(searchActivityIndicator!)
        searchActivityIndicator?.startAnimating()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // start searching for places
        print(searchText)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
