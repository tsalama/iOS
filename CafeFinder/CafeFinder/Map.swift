//
//  Map.swift
//  CafeFinder
//
//  Created by tsalama on 10/17/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit
import MapKit

class Map: UIViewController {
    
    var address:String!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapSelection: UISegmentedControl!
    
    @IBAction func mapSelectionAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = MKMapType.Hybrid
        }
        else if sender.selectedSegmentIndex == 1 {
            mapView.mapType = MKMapType.Standard
        }
        else if sender.selectedSegmentIndex == 2 {
            mapView.mapType = MKMapType.Satellite
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = false
        let geo = CLGeocoder()
        let address = self.address
        
        geo.geocodeAddressString (address!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if placemarks != nil && placemarks!.count > 0 {
                let placemark:CLPlacemark = placemarks![0]
                let latitude = placemark.location!.coordinate.latitude
                let longitude = placemark.location!.coordinate.longitude
                
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
