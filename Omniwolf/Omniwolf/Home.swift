//
//  Home.swift
//  Omniwolf
//
//  Created by Tarek Salama, Mustafa Salih on 1/14/17.
//  Copyright © 2017 Omniwolf. All rights reserved.
//

import UIKit

class Home: UIViewController {
    var devices: NSArray = NSArray()
    var done = false
    
    @IBAction func fetch(sender: UIButton) {
        self.getJsonData()
        
        while (done == false) {}
        
        performSegue(withIdentifier: "fetch", sender: self)
    }
    
    
    
    func getJsonData() {
        
        let queryURL = "http://api.omniwolf.io/device/pull"
        let url = URL(string: queryURL)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url as URL, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
//            let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            let json = try? JSONSerialization.jsonObject(with: data!) as! NSDictionary
            let array = json?["Items"] as! NSArray
            
            print(array)
            
            self.devices = array
            
            var request = URLRequest(url: url)
            
            request.addValue("CORS", forHTTPHeaderField: "Mode")
            request.addValue("application/javascript", forHTTPHeaderField: "Content-Type")
            
            self.done = true
        })
        
        jsonQuery.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "fetch"){
            if let viewController: TableViewController = segue.destination as? TableViewController {
                viewController.devices = self.devices
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // For use in foreground
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
