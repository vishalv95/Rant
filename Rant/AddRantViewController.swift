 //
//  AddRantViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData


class AddRantViewController: UIViewController, UIPopoverPresentationControllerDelegate, TagAction, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var tag:String?
    
    @IBAction func saveAction(sender: AnyObject) {
        
        let alert:UIAlertController = UIAlertController(title: "Confirm Rant", message: "Are you sure you want to post this rant?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            let title = self.titleTextField.text!
            let body = self.bodyTextField.text!
            let defaults = NSUserDefaults.standardUserDefaults()
            let account = retrieveAccountForUser((defaults.objectForKey("username") as? String)!) as! Account
            
            
            if let rantTag = self.tag {
                self.storeRant(title, body: body, account: account, tags: rantTag, upvotes: 0, downvotes: 0, ts: NSDate())
            }
            else{
                self.storeRant(title, body: body, account: account, tags: "Misc", upvotes: 0, downvotes: 0, ts: NSDate())
                
            }
            self.performSegueWithIdentifier("saveRantSegue", sender: self)
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
        
        

        
    }
    
    func sendTag(tag: String) {
        self.tag = tag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTextField.delegate = self
        
        // Do any additional setup after loading the view.
        self.titleTextField.layer.borderWidth = 1.0;
        self.titleTextField.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.titleTextField.layer.cornerRadius = 8;
        
        self.bodyTextField.layer.borderWidth = 1.0;
        self.bodyTextField.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.bodyTextField.layer.cornerRadius = 8;
        
        self.bodyTextField.text = "Rant Here..."
        self.bodyTextField.textColor = UIColor.lightGrayColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func storeRant(title:String, body:String, account:Account, tags:String, upvotes:Int, downvotes:Int, ts:NSDate){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entityForName("Rant", inManagedObjectContext: managedContext)
        let rant = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        // Set the attribute values
        rant.setValue(title, forKey: "title")
        rant.setValue(body, forKey: "body")
        rant.setValue(account, forKey: "account")
        rant.setValue(tags, forKey: "tags")
        rant.setValue(Int(upvotes), forKey: "upvotes")
        rant.setValue(Int(downvotes), forKey: "downvotes")
        rant.setValue(ts, forKey: "ts")
        
        // Add rants to the account
        let rants = account.mutableSetValueForKey("rant")
        rants.addObject(rant)

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
            bodyTextField.text = "Rant Here..."
            bodyTextField.textColor = UIColor.lightGrayColor()
        }
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addCategorySegue" {
            let vc = segue.destinationViewController as! TagTableViewController
            let controller = vc.popoverPresentationController
            vc.tagAction = self
            if controller != nil {
                controller?.delegate = self
                
            }
        }
        
    }

}




