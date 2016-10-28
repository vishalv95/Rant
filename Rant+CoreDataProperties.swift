//
//  Rant+CoreDataProperties.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/27/16.
//  Copyright © 2016 group4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Rant {

    @NSManaged var body: String?
    @NSManaged var downvotes: NSNumber?
    @NSManaged var tags: String?
    @NSManaged var title: String?
    @NSManaged var ts: NSDate?
    @NSManaged var upvotes: NSNumber?
    @NSManaged var account: Account?
    @NSManaged var comment: NSSet?

}
