//
//  CDHelper.swift
//  CRUD
//
//  Created by Matthew Parker on 8/14/15.
//  Copyright © 2015 BitFountain. All rights reserved.
//

import Foundation
import CoreData

class CDHelper{
    
    static let sharedInstance = CDHelper()
    
    lazy var storesDirectory: NSURL = {
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()

    lazy var localStoreURL: NSURL = {
        let url = self.storesDirectory.URLByAppendingPathComponent("Bikes.sqlite")
        return url
        }()
    
    lazy var modelURL: NSURL = {
        let bundle = NSBundle.mainBundle()
        if let url = bundle.URLForResource("Model", withExtension: "momd") {
            return url
        }
        print("CRITICAL - Managed Object Model file not found")
        abort()
        }()
    
    lazy var model: NSManagedObjectModel = {
        return NSManagedObjectModel(contentsOfURL:self.modelURL)!
        }()
    
    lazy var coordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.localStoreURL, options: nil)
        } catch {
            print("Could not add the peristent store")
            abort()
        }
        
        return coordinator
        }()
}


func fetchBikes(context: NSManagedObjectContext)-> [Bike]? {
    let request = NSFetchRequest(entityName: "Bike")
    
    let descriptor = NSSortDescriptor(key: "name", ascending: true)
    request.sortDescriptors = [descriptor]
    
    do {
        guard let bikes = try context.executeFetchRequest(request) as? [Bike] else { return nil }
        return bikes
        
    } catch {
        print("We couldn't fetch!")
    }
    
    return nil
}

func seedData(context: NSManagedObjectContext) {
    // Check to make sure there are no entries already in the database
    guard let existingBikes = fetchBikes(context) where existingBikes.count <= 0 else { return }
    
    let firstBike = (name: "HardTail", brand: "Connor", model: "8500 Deore", fork: "Suntour XCM", wheelSize: 29.0)
    
    guard let newBike = NSEntityDescription.insertNewObjectForEntityForName("Bike", inManagedObjectContext: context) as? Bike else { return }
    
    newBike.name = firstBike.name
    newBike.brand = firstBike.brand
    newBike.model = firstBike.model
    newBike.fork = firstBike.fork
    newBike.wheelSize = firstBike.wheelSize
    
    // save the changes
    do {
        try context.save()
    } catch {
        print("Error saving!!")
    }
}
