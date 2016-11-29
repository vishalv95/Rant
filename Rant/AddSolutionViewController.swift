//
//  AddSolutionViewController.swift
//  Rant
//
//  Created by Timmy Gianitsos on 11/3/16.
//  Copyright © 2016 group4. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddSolutionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var slogan: UITextField!
    @IBOutlet weak var summary: UITextView!
    var rant:Rant!
    
    // Called when the user touches on the main view (outside the UITextField).
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.summary.delegate = self
        self.summary.layer.borderWidth = 1.0;
        self.summary.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.summary.layer.cornerRadius = 8;
        self.summary.textColor = UIColor.lightGrayColor()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if summary.textColor == UIColor.lightGrayColor() {
            summary.text = nil
            summary.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if summary.text.isEmpty {
            summary.text = "Enter Summary..."
            summary.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBAction func saveButtonPressed() {
        //TODO prevent posting if a field is blank
        let alert:UIAlertController = UIAlertController(title: "Confirm Solution", message: "Are you sure you want to post this solution?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            let titleText = self.titleField.text!
            let sloganText = self.slogan.text!
            let summaryText = self.summary.text!
            let defaults = NSUserDefaults.standardUserDefaults()
            let account = retrieveAccountForUser((defaults.objectForKey("username") as? String)!) as! Account
            
            self.storeSolution(titleText, slogan: sloganText, summary: summaryText, account: account)
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func storeSolution(title: String, slogan: String, summary: String, account: Account) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entityForName("Solution", inManagedObjectContext: managedContext)
        let solution = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        // Set the attribute values
        solution.setValue(title, forKey: "title")
        solution.setValue(slogan, forKey: "slogan")
        solution.setValue(summary, forKey: "summary")
        solution.setValue(account, forKey: "account")
        solution.setValue(self.rant, forKey: "rant")
        
        // Add solution to the rant
        var solutions = rant.mutableSetValueForKey("solution")
        solutions.addObject(solution)
        
        // Add solution to the account
        solutions = account.mutableSetValueForKey("solution")
        solutions.addObject(solution)
        
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