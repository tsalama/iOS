//
//  Discover.swift
//  CafeFinder
//
//  Created by tsalama on 10/17/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit

class Discover: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cafes:NSArray = NSArray()
    var cafesDetails:NSDictionary = NSDictionary()
    var done = false
    
    @IBOutlet weak var cafesTable: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cafe:NSDictionary = cafes[indexPath.row] as! NSDictionary
        
        let cell = cafesTable.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        
        cell.name.text = ("\(cafe.valueForKey("name") as! String)")
        if cafe.valueForKey("rating") != nil {
            cell.rating.text = ("Google Rating: \(cafe.valueForKey("rating") as! Double)/5")
        }
        if cafe.valueForKey("icon") != nil {
            cell.pic.image = UIImage(data: NSData(contentsOfURL: NSURL(string: cafe.valueForKey("icon") as! String)!)!)
        }
        return cell
    }
    
    func getJsonData(indexPath: NSIndexPath) {
        let cafe:NSDictionary = cafes[indexPath.row] as! NSDictionary
        
        let queryURL:String = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(cafe.valueForKey("place_id") as! String)&key=AIzaSyDkGZiAS8IPfot1Pmv25FG5GW4sPBnj8Gs"
        
        let url = NSURL(string: queryURL)!
        let urlSession = NSURLSession.sharedSession()
        
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            let jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            
            print(jsonResult)
            
            self.cafesDetails = jsonResult["result"] as! NSDictionary
            
            for index in 0...self.cafes.count - 1
            {
                print(self.cafes[index]["name"] as! String)
            }
            
            self.done = true
        })
        
        jsonQuery.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.done = false
        
        if(segue.identifier == "discoverDetails"){
            let cell = sender as! UITableViewCell
            let indexPath = self.cafesTable.indexPathForCell(cell)
            self.getJsonData(indexPath!)
            while (self.done == false) {}
            if let viewController: DiscoverDetails = segue.destinationViewController as? DiscoverDetails {
                viewController.cafe = cafesDetails
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
