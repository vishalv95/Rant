//
//  CoreDataControls.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import Foundation
import CoreData
import UIKit


func clearRantCoreData() {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: "Rant")
    var fetchedResults:[NSManagedObject]
    
    do {
        try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        
        if fetchedResults.count > 0 {
            
            for result:AnyObject in fetchedResults {
                managedContext.deleteObject(result as! NSManagedObject)
                print("\(result.valueForKey("title")!) has been Deleted")
            }
        }
        try managedContext.save()
        
    } catch {
        // If an error occurs
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
    
}

func retrieveRants() -> [NSManagedObject] {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName:"Rant")
    var fetchedResults:[NSManagedObject]? = nil
    
    do {
        try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
    } catch {
        // If an error occurs
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
    
    return(fetchedResults)!
    
}


func retrieveComments() -> [NSManagedObject] {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName:"Comment")
    var fetchedResults:[NSManagedObject]? = nil
    
    do {
        try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
    } catch {
        // If an error occurs
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
    
    return(fetchedResults)!
    
}

func retrieveCommentsFromRant(rantID:NSManagedObjectID) -> [NSManagedObject] {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    

    let fetchRequest = NSFetchRequest(entityName:"Comment")
    var fetchedResults:[NSManagedObject]? = nil
    
    do {
        try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
    } catch {
        // If an error occurs
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
    
    return(fetchedResults)!
    
}


func retrieveAccountForUser(username:String) -> NSManagedObject {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName:"Account")
    var fetchedResults:[NSManagedObject]? = nil
    
    let predicate = NSPredicate(format: "user = %@", username)
    fetchRequest.predicate = predicate
    
    do {
        try fetchedResults = managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        
    } catch {
        // If an error occurs
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
    return(fetchedResults![0])
}

func retrieveFavoritesForUser(username:String) -> NSSet {
    let account = retrieveAccountForUser(username) as! Account
    let favorites = account.mutableSetValueForKey("rant")
    return favorites

}

func retrieveFavoritesForThisUser() -> NSSet {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let username = defaults.objectForKey("username") as? String{
        let account = retrieveAccountForUser(username) as! Account
        return account.favorites!
    }
    else{
     return NSSet()
    }
}