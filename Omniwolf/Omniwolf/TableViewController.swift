//
//  TableViewController.swift
//  Omniwolf
//
//  Created by Tarek Salama on 1/14/17.
//  Copyright © 2017 Omniwolf. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController,  NSFetchedResultsControllerDelegate {
    var devices: NSArray = NSArray()

    @IBOutlet weak var deviceView: UITableView!
        
    var data: NSFetchedResultsController<Device> = NSFetchedResultsController<Device>()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        data = getFetchResultsController() as! NSFetchedResultsController<Device>
        
        data.delegate = self
        do {
            try data.performFetch()
        }
        catch _ {
        }
        
    }
    
    func listFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        data = NSFetchedResultsController(fetchRequest: listFetchRequest() as! NSFetchRequest<Device>, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return data as! NSFetchedResultsController<NSFetchRequestResult>
    }
    
    
    @IBAction func newDevice(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "new", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections  = data.sections?.count
        return numberOfSections!
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.deviceView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = data.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deviceView.dequeueReusableCell(withIdentifier: "dataCell", for:indexPath)
        let dev = data.object(at: indexPath as IndexPath)
        cell.textLabel?.text = dev.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let dev = data.object(at: indexPath) 
            context.delete(dev)
            do {
                try context.save()
            } catch _ {
                NSLog("Error deleting element.")
            }
            
            deviceView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if segue.identifier == "data" {
            let cell = sender as! UITableViewCell
            let indexPath = self.deviceView.indexPath(for: cell)
            let dest: DetailedViewController = segue.destination as! DetailedViewController
            let row = data.object(at: indexPath!) 
            dest.dev = row
        
            dest.devices = self.devices
        }
    }
}

