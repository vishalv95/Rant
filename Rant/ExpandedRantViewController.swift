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
    
    var rant:NSManagedObject? = nil
    
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
        if let comments = (rant as? Rant)!.comment {
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
//        TODO: Choose response type alert prompt
        performSegueWithIdentifier("addCommentSegue", sender: self)
        
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
            ctvc.rant = rant as? Rant
        }
        
        
        if segue.identifier == "addCommentSegue",
            let acvc = segue.destinationViewController as? AddCommentViewController{
            acvc.rant = rant as? Rant
        }
        
        
        
    }
 

}
