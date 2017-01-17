//
//  UIWebViewController.swift
//  CafeFinder
//
//  Created by Tarek Salama on 11/18/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit

class UIWebViewController: UIViewController {
    
    var website:String!
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url: NSURL?
        
        if website != nil {
            url = NSURL(string: website)
        
            let request = NSURLRequest(URL: url!)
        
            webView.loadRequest(request)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}