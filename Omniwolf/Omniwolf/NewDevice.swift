//
//  DetailViewController.swift
//  Omniwolf
//
//  Created by Tarek Salama, Mustafa Salih on 1/14/17.
//  Copyright © 2017 Omniwolf. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewDevice: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataViewController: NSFetchedResultsController<Device> = NSFetchedResultsController<Device>()
    
    @IBOutlet weak var deviceField: UITextField!
    
    @IBAction func saveDevice(sender: UIBarButtonItem) {
        if deviceField.text == "" {
            NSLog("Invalid!")
            return
        }
        let ent = NSEntityDescription.entity(forEntityName: "Device", in: self.context)
        
        let dev:Device = Device(entity: ent!, insertInto: self.context)
        dev.name = deviceField.text
        do {
            try self.context.save()
        } catch _ {
            NSLog("Error saving")
        }
        navigationController!.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
