//
//  SolutionInfoViewcontroller.swift
//  Rant
//
//  Created by Timmy Gianitsos on 11/28/16.
//  Copyright © 2016 group4. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SolutionInfoViewController: UIViewController {
    
    var solution: Solution!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var sloganText: UITextView!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var contributions: UITextField!
    @IBOutlet weak var contributors: UITextField!
    
    @IBAction func contributions(sender: UITextField, forEvent event: UIEvent) {
        if (Int(sender.text!) != nil) {
            storeContribution(Int(sender.text!)!)
        }
        else {
            sender.text! = String(solution.contributions)
        }
    }
    
    @IBAction func contributors(sender: UITextField, forEvent event: UIEvent) {
        if (Int(sender.text!) != nil) {
            storeContributors(Int(sender.text!)!)
        }
        else {
            sender.text! = String(solution.contributors)
        }
    }
    
    
    func storeContribution(contributions: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Set the attribute values
        solution.setValue(contributions, forKey: "contributions")
        
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
    
    func storeContributors(contributors: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Set the attribute values
        solution.setValue(contributors, forKey: "contributors")
        
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
    
    override func viewDidAppear(animated: Bool) {
        if let prof = solution.account?.profileImage {
            profileImage.image = UIImage(data:prof,scale:1.0)
        }
        titleText.text! = solution.title!
        sloganText.text! = solution.slogan!
        summaryText.text! = solution.summary!
        contributions.text! = String(solution.contributions!)
        contributors.text! = String(solution.contributors!)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "timelineSegue",
            let esvc = segue.destinationViewController as? ExpandedSolutionViewController
        {
            esvc.solution = self.solution
        }
        
    }

    
}