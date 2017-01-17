//
//  DiscoverDetails.swift
//  CafeFinder
//
//  Created by Tarek Salama on 11/16/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit
import CoreData

class DiscoverDetails: UIViewController {
    
    var cafe:NSDictionary = NSDictionary()
    var cafeObj:Cafe? = nil
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addedLabel: UILabel!
    @IBAction func visitWebsite(sender: UIButton) {
        performSegueWithIdentifier("web", sender: self)
    }
    @IBAction func addFavorite(sender: AnyObject) {
        
        if cafeObj == nil {
            let ent = NSEntityDescription.entityForName("Cafe", inManagedObjectContext: self.context)
            cafeObj = Cafe(entity: ent!, insertIntoManagedObjectContext: self.context)
        }
        
        cafeObj!.name = nameLabel.text
        cafeObj!.pic = NSData(contentsOfURL: NSURL(string: cafe.valueForKey("icon") as! String)!)
        cafeObj!.address = addressLabel.text
        
        do {
            try self.context.save()
        } catch _ {
        }
        
        addedLabel.textColor = UIColor.greenColor()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = false
        self.addedLabel.textColor = UIColor.blackColor()
        nameLabel.text = cafe["name"] as? String
        phoneLabel.text = cafe["formatted_phone_number"] as? String
        addressLabel.text = cafe["vicinity"] as? String
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "web"){
            if let viewController: UIWebViewController = segue.destinationViewController as? UIWebViewController {
                viewController.website = cafe["website"] as? String
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
