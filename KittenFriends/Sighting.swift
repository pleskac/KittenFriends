//
//  Sighting.swift
//  KittenFriends
//
//  Created by Mark Pleskac on 3/18/15.
//  Copyright (c) 2015 Mark Pleskac. All rights reserved.
//

import Foundation
import CoreData

class Sighting: NSManagedObject {

    @NSManaged var username: String
    @NSManaged var lat: NSNumber
    @NSManaged var long: NSNumber
    @NSManaged var color: String

}
