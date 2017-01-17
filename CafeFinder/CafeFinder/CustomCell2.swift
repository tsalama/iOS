//
//  CustomCell2.swift
//  CafeFinder
//
//  Created by Tarek Salama on 11/18/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import UIKit
import Foundation

class CustomCell2: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
