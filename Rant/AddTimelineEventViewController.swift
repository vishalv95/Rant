//
//  AddTimelineEventViewController.swift
//  Rant
//
//  Created by Alana Layton on 11/26/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class AddTimelineEventViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var bodyTextField: UITextView!
    
    var solution:Solution? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bodyTextField.delegate = self
        self.bodyTextField.layer.borderWidth = 1.0;
        self.bodyTextField.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.bodyTextField.layer.cornerRadius = 8;
        
        self.bodyTextField.text = "Timeline Event Here..."
        self.bodyTextField.textColor = UIColor.lightGrayColor()

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if bodyTextField.textColor == UIColor.lightGrayColor() {
            bodyTextField.text = nil
            bodyTextField.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if bodyTextField.text.isEmpty {
            bodyTextField.text = "Timeline Event Here..."
            bodyTextField.textColor = UIColor.lightGrayColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        let alert:UIAlertController = UIAlertController(title: "Confirm Solution Timeline Event", message: "Are you sure you want to add this timeline event?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            let body = self.bodyTextField.text!
            let defaults = NSUserDefaults.standardUserDefaults()
            let account = retrieveAccountForUser((defaults.objectForKey("username") as? String)!) as! Account
            
            self.storeSolutionTimeline(body, account: account, ts: NSDate())
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)

    }
    
    func storeSolutionTimeline(body:String, account:Account, ts:NSDate) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entityForName("Timeline", inManagedObjectContext: managedContext)
        let timeline = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        
        // Set the attribute values
        timeline.setValue(body, forKey: "body")
        timeline.setValue(ts, forKey: "ts")
        
        // Add timelines to the solution
        var timelineEvents = solution!.mutableSetValueForKey("timeline")
        timelineEvents.addObject(timeline)
        
        
        
        //         Commit the changes
        do {
            try managedContext.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
