//
//  ExpandedRantViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData


class ExpandedRantViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    @IBOutlet weak var sampleComment1: UILabel!
    @IBOutlet weak var sampleComment2: UILabel!
    
    var rant:Rant? = nil
    
    override func viewDidAppear(animated: Bool) {
        titleLabel.text = rant!.valueForKey("title") as? String
        bodyLabel.text = rant!.valueForKey("body") as? String
        let acc = rant!.valueForKey("account") as? Account
        usernameLabel.text = acc!.user
        
        if let upvotes = rant!.valueForKey("upvotes"){
            if let downvotes = rant!.valueForKey("downvotes"){
                let score = (upvotes as! Int) - (downvotes as! Int)
                scoreLabel.text = "\(score)"
            }
            else{
                scoreLabel.text = "0"
            }
        }
        else{
            scoreLabel.text = "0"
        }
        if let comments = rant!.comment {
            var commentsArray:[Comment] = Array(comments) as! [Comment]
            commentsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
            
            if comments.count > 0 {
                let comment1 = commentsArray[0] as? Comment
                guard let user1 = comment1?.account?.user! else { return }
                guard let body1 = comment1?.body! else { return }
                sampleComment1.text = "\(user1): \(body1)"
            }
            else{
                sampleComment1.text = ""
            }
            
           
            if comments.count > 1 {
                let comment2 = commentsArray[1] as? Comment
                guard let user2 = comment2?.account?.user! else { return }
                guard let body2 = comment2?.body! else { return }
                sampleComment2.text = "\(user2): \(body2)"
            }
            else{
                sampleComment2.text = ""
            }
        }
        else{
            sampleComment1.text = ""
            sampleComment2.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addResponseAction(sender: AnyObject) {

        // create the alert
        let alert = UIAlertController(title: "Compose", message: "Which type of response do you want to make?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        let defaults = NSUserDefaults.standardUserDefaults()
        let username = defaults.objectForKey("username") as? String

        if rant?.account?.user == username {
            alert.addAction(UIAlertAction(title: "Edit my Rant", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
                self.performSegueWithIdentifier("editRantSegue", sender: self)
            }))
        }
        alert.addAction(UIAlertAction(title: "Comment", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("addCommentSegue", sender: self)
        }))
        
//        alert.addAction(UIAlertAction(title: "Solution", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction!) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))

        
        // show the alert
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    
    @IBAction func upVoteButtonPressed(sender: AnyObject) {
        let newScore = Int(scoreLabel.text!)! + 1
        scoreLabel.text = "\(newScore)"
        rant!.upVote()
        self.upVoteButton.enabled = false
        self.downVoteButton.enabled = true
    }
    
    @IBAction func downVoteButtonPressed(sender: AnyObject) {
        let newScore = Int(scoreLabel.text!)! - 1
        scoreLabel.text = "\(Int(newScore))"
        rant!.downVote()
        self.upVoteButton.enabled = true
        self.downVoteButton.enabled = false
    }
    

    @IBAction func favoriteButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let account = retrieveAccountForUser((defaults.objectForKey("username") as? String)!) as! Account

        let favorites = account.mutableSetValueForKey("favorites")
        favorites.addObject(rant!)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "commentsSegue",
            let ctvc = segue.destinationViewController as? CommentTableViewController{
            ctvc.rant = rant
        }
        
        
        if segue.identifier == "addCommentSegue",
            let acvc = segue.destinationViewController as? AddCommentViewController{
            acvc.rant = rant
        }
        
        
        if segue.identifier == "editRantSegue",
            let arvc = segue.destinationViewController as? AddRantViewController{
            arvc.header = "Edit Rant"
            arvc.titleText = titleLabel.text
            arvc.body = bodyLabel.text
            arvc.editRant = rant
        }
        
        
        
        
    }
 

}
