//
//  Cafe.swift
//  CafeFinder
//
//  Created by Tarek Salama on 11/16/16.
//  Copyright © 2016 tsalama. All rights reserved.
//

import Foundation
import CoreData

class Cafe: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var pic: NSData?
}
