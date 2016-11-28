//
//  Solution+CoreDataProperties.swift
//  Rant
//
//  Created by Alana Layton on 11/25/16.
//  Copyright © 2016 group4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
import ISTimeline

extension Solution {

    @NSManaged var body: String?
    @NSManaged var ts: NSDate?
    @NSManaged var account: Account?
    @NSManaged var rant: Rant?
    @NSManaged var timeline: Timeline?
}