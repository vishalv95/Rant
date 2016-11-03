//
//  Rant.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Rant: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    func downVote() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let down = (self.downvotes as! Int) + 1
        self.downvotes = NSNumber(integer: down)
        
        // Commit the changes
        do {
            try managedContext.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func upVote() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let down = (self.upvotes as! Int) + 1
        self.upvotes = NSNumber(integer: down)
        
        // Commit the changes
        do {
            try managedContext.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }

}
