//
//  Timeline+CoreDataProperties.swift
//  Rant
//
//  Created by Alana Layton on 11/27/16.
//  Copyright © 2016 group4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Timeline {

    @NSManaged var body: String?
    @NSManaged var ts: NSDate?
    @NSManaged var solution: Solution?

}
