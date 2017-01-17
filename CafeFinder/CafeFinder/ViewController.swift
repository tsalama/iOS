//
//  ViewController.swift
//  CafeFinder
//
//  Created by tsalama on 10/17/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0 
    var cafes: NSArray = NSArray()
    var done = false

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        print("location = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
    }

    @IBAction func discover(sender: UIButton) {
        self.getJsonData()
        
        while (done == false) {}
        
        performSegueWithIdentifier("discover", sender: self)
    }
    
    func getJsonData() {
        
        let lat:Double
        let long:Double
        
        // if CoreLocation malfunction or Location Services disallowed, default to ASU
        if (self.latitude == 0.0 || self.longitude == 0.0) {
            lat = 33.423708
            long = -111.939199
        }
        else {
            lat = self.latitude
            long = self.longitude
        }
        
        
        let queryURL:String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=3000&type=cafe&key=AIzaSyDkGZiAS8IPfot1Pmv25FG5GW4sPBnj8Gs"
        
        let url = NSURL(string: queryURL)!
        let urlSession = NSURLSession.sharedSession()
        
    
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            let jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            
            print(jsonResult)
            
            self.cafes = jsonResult["results"] as! NSArray

            for index in 0...self.cafes.count - 1
            {
                print(self.cafes[index]["name"] as! String)
            }
            
            self.done = true
        })

        jsonQuery.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "discover"){
            if let viewController: Discover = segue.destinationViewController as? Discover {
                viewController.cafes = self.cafes
            }
        }
    }

    
    @IBAction func favorites(sender: UIButton) {
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

