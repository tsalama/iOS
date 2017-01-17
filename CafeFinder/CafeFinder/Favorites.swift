//
//  Favorites.swift
//  CafeFinder
//
//  Created by tsalama on 10/17/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit
import CoreData

class Favorites: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var favoritesTable: UITableView!
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchResults = [Cafe]()
    
    func fetchRecord() -> Int {
        let fetchRequest = NSFetchRequest(entityName: "Cafe")
        var x   = 0
        fetchResults = ((try? context.executeFetchRequest(fetchRequest)) as? [Cafe])!
        
        
        x = fetchResults.count
        
        print(x)
        
        
        return x
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = favoritesTable.dequeueReusableCellWithIdentifier("customCell2", forIndexPath: indexPath) as! CustomCell2
        
        cell.name.text = fetchResults[indexPath.row].name
        cell.address.text = fetchResults[indexPath.row].address
        if fetchResults[indexPath.row].pic != nil
        {
            cell.pic.image = UIImage(data: fetchResults[indexPath.row].pic! as NSData)
        }
        
        return cell
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        favoritesTable.setEditing(editing, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let restaurant = fetchResults[indexPath.row]
            context.deleteObject(restaurant)
            do {
                try context.save()
            } catch _ {
            }
            
            self.favoritesTable.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "map" {
            let selectedIndex:NSIndexPath = self.favoritesTable.indexPathForCell(sender as! CustomCell2)!
            if let map: Map = segue.destinationViewController as? Map {
                map.address = fetchResults[selectedIndex.row].address!
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}