//
//  Solution+CoreDataProperties.swift
//  Rant
//
//  Created by Timmy Gianitsos on 11/3/16.
//  Copyright © 2016 group4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Solution {

    @NSManaged var title: String?
    @NSManaged var slogan: String?
    @NSManaged var summary: String?
    @NSManaged var likes: NSNumber?
    @NSManaged var dislikes: NSNumber?
    @NSManaged var contributions: NSNumber?
    @NSManaged var contributors: NSNumber?
    @NSManaged var comments: NSSet?
    @NSManaged var event: NSSet?
    @NSManaged var owner: Account?
    @NSManaged var rant: Rant?

}
