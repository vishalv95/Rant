//
//  Solution+CoreDataProperties.swift
//
//
//  Created by Timmy Gianitsos on 11/28/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Solution {
    
    @NSManaged var body: String?
    @NSManaged var ts: NSDate?
    @NSManaged var title: String?
    @NSManaged var summary: String?
    @NSManaged var slogan: String?
    @NSManaged var contributions: NSNumber?
    @NSManaged var contributors: NSNumber?
    @NSManaged var account: Account?
    @NSManaged var rant: Rant?
    @NSManaged var timeline: NSSet?
    
}
