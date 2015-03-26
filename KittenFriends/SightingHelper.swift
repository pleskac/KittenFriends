//
//  SightingHelper.swift
//  KittenFriends
//
//  Created by Mark Pleskac on 3/21/15.
//  Copyright (c) 2015 Mark Pleskac. All rights reserved.
//

import Foundation
import CoreData

// Helper function for accessing Sighting information
// Single point of entry for read/write
class SightingHelper: NSObject {
    var managedObjectContext: NSManagedObjectContext;
    
    init(fromAppDelegate del: AppDelegate){
        self.managedObjectContext = del.managedObjectContext!
    }
    
    init(fromManagedObjectContext objContext: NSManagedObjectContext){
        self.managedObjectContext = objContext
    }
    
    func addSighting(userName: NSString, color: NSString, lat: Double, long: Double){
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Sighting", inManagedObjectContext: self.managedObjectContext) as Sighting
        
        newItem.username = userName
        newItem.lat = lat
        newItem.long = long
        newItem.color = color
    }
    
    func getSightings() -> [Sighting]{
        // Create a new fetch request using the Sighting entity
        let fetchRequest = NSFetchRequest(entityName: "Sighting")
        
        // Execute the fetch request, and cast the results to an array of Sighting objects
        if let fetchResults = managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [Sighting] {
            return fetchResults;
        }
        
        return [];
    }
    
    func getNumberOfSightings() -> Int{
        return getSightings().count;
    }
}
