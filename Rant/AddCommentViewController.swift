//
//  AddCommentViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/27/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class AddCommentViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var bodyTextField: UITextView!
    var rant:Rant? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bodyTextField.delegate = self
        self.bodyTextField.layer.borderWidth = 1.0;
        self.bodyTextField.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.bodyTextField.layer.cornerRadius = 8;
        
        self.bodyTextField.text = "Comment Here..."
        self.bodyTextField.textColor = UIColor.lightGrayColor()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if bodyTextField.textColor == UIColor.lightGrayColor() {
            bodyTextField.text = nil
            bodyTextField.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if bodyTextField.text.isEmpty {
            bodyTextField.text = "Comment Here..."
            bodyTextField.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        let alert:UIAlertController = UIAlertController(title: "Confirm Comment", message: "Are you sure you want to post this comment?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            let body = self.bodyTextField.text!
            let defaults = NSUserDefaults.standardUserDefaults()
            let account = retrieveAccountForUser((defaults.objectForKey("username") as? String)!) as! Account

            self.storeComment(body, account: account, ts: NSDate())
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)

    }
    
    func storeComment(body:String, account:Account, ts:NSDate) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entityForName("Comment", inManagedObjectContext: managedContext)
        let comment = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        // Set the attribute values
        comment.setValue(body, forKey: "body")
        comment.setValue(account, forKey: "account")
        comment.setValue(ts, forKey: "ts")
        
        // Add comments to the rant
        var comments = rant!.mutableSetValueForKey("comment")
        comments.addObject(comment)
        
        
        // Add comments to the account
        comments = account.mutableSetValueForKey("comment")
        comments.addObject(comment)
        
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
