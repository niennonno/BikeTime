//
//  Bike+CoreDataProperties.swift
//  BikeTime
//
//  Created by Alex Dearden on 20/1/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bike {

    @NSManaged var brand: String?
    @NSManaged var model: String?
    @NSManaged var name: String?
    @NSManaged var wheelSize: NSNumber?
    @NSManaged var fork: String?

}
