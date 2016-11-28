//
//  Account+CoreDataProperties.swift
//  Rant
//
//  Created by Vishal Vusirikala on 11/1/16.
//  Copyright © 2016 group4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var city: String?
    @NSManaged var password: String?
    @NSManaged var profileImage: NSData?
    @NSManaged var state: String?
    @NSManaged var user: String?
    @NSManaged var comment: NSSet?
    @NSManaged var favorites: NSSet?
    @NSManaged var rant: NSSet?
    @NSManaged var solution: NSSet?

}
