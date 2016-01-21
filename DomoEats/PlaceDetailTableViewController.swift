//
//  PlaceDetailTableViewController.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/20/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
import MapKit
class PlaceDetailTableViewController: UITableViewController {
    var placeProperties:[String:AnyObject?] = [String:AnyObject?]()
    var placeAnnotation:MapPlaces!
    var place:Places?
    
    @IBOutlet weak var placeMapView: MKMapView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeRatingImage: UIImageView!
    private let placePropertyCellReuseID = "placePropertyCell"
    private let placeLikeCellReuseID = "placeLikeCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //setup the map view
        placeMapView.addAnnotation(placeAnnotation)
        
        let region = MKCoordinateRegionMakeWithDistance(placeAnnotation.coordinate, 500, 500)
        self.placeMapView.setRegion(region, animated: false)
        
        tableView.registerNib(UINib(nibName: "PlaceDetailCell", bundle: nil), forCellReuseIdentifier: placePropertyCellReuseID)
        tableView.registerNib(UINib(nibName: "LikeThisTableViewCell", bundle: nil), forCellReuseIdentifier: placeLikeCellReuseID)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadPlaceData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placeProperties.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(placePropertyCellReuseID, forIndexPath: indexPath) as! PlaceDetailTableViewCell
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadPlaceData() {
        if place != nil {
            if place?.name != nil {
                placeNameLabel.text = place?.name!
            }
            place?.getStarRatingImage({ (image) -> Void in
                self.placeRatingImage.image = image
            })
        }
    }
    
    private func refreshHeaderView() {
        // refresh map view
        
    }

}
