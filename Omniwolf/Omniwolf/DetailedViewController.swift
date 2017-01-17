//
//  DetailedViewController.swift
//  Omniwolf
//
//  Created by Tarek Salama, Mustafa Salih on 1/14/17.
//  Copyright © 2017 Omniwolf. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class DetailedViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    var devices: NSArray = NSArray()
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    

    var dev:Device? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        name.text = dev?.name
        
        if dev!.name == "Alert Systems"
        {
            var details = devices[1] as! NSDictionary
            label1.text = details["Dev"] as? String
            label2.text = details["Data"] as? String
            details = devices[2] as! NSDictionary
            label3.text = details["Dev"] as? String
            label4.text = details["Data"] as? String
        }
        else if dev?.name == "Internal Air Quality"
        {
            var details = devices[3] as! NSDictionary
            label1.text = details["Dev"] as? String
            label2.text = details["Data"] as? String
            details = devices[0] as! NSDictionary
            label3.text = details["Dev"] as? String
            let str = details["Data"] as? String
            let index = str?.index((str?.startIndex)!, offsetBy: 2)
            label4.text = str?.substring(to: index!)
        }
    }
}

