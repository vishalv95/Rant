//
//  ExpandedRantViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData


class ExpandedRantViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    @IBOutlet weak var sampleComment1: UILabel!
    @IBOutlet weak var sampleComment2: UILabel!
    
    @IBOutlet weak var sampleSolution1: UITextView!
    @IBOutlet weak var sampleSolution2: UITextView!
    
    var rant:Rant? = nil
    
    override func viewDidAppear(animated: Bool) {
        
        
        titleLabel.text = rant!.valueForKey("title") as? String
        bodyLabel.text = rant!.valueForKey("body") as? String
        let acc = rant!.valueForKey("account") as? Account
        usernameLabel.text = acc!.user
        
        if let score = rant!.valueForKey("score"){
            scoreLabel.text = "\(score)"
        }
        
        if let comments = rant!.comment {
            var commentsArray:[Comment] = Array(comments) as! [Comment]
            commentsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
            
            if comments.count > 0 {
                let comment1 = commentsArray[0]
                guard let user1 = comment1.account?.user! else { return }
                guard let body1 = comment1.body else { return }
                sampleComment1.text = "\(user1): \(body1)"
            }
            else{
                sampleComment1.text = ""
            }
            
            if comments.count > 1 {
                let comment2 = commentsArray[1]
                guard let user2 = comment2.account?.user! else { return }
                guard let body2 = comment2.body else { return }
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
        
        
        if let solutions = rant!.solution {
            var solutionsArray:[Solution] = Array(solutions) as! [Solution]
            solutionsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
            
            if solutions.count > 0 {
                let solutions1 = solutionsArray[0]
                guard let user1 = solutions1.account?.user! else { return }
                guard let body1 = solutions1.title else { return }
                sampleSolution1.text = "\(user1): \(body1)"
            }
            else{
                sampleSolution1.text = ""
            }
            
            if solutions.count > 1 {
                let solutions2 = solutionsArray[1]
                guard let user2 = solutions2.account?.user! else { return }
                guard let body2 = solutions2.title else { return }
                sampleSolution2.text = "\(user2): \(body2)"
            }
            else{
                sampleSolution2.text = ""
            }
        }
        else{
            sampleSolution1.text = ""
            sampleSolution2.text = ""
        }

    }
    
    func usernameLabelPressed(gr:UITapGestureRecognizer) {
        self.performSegueWithIdentifier("otherUserProfileSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.userInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: "usernameLabelPressed:")
        usernameLabel.addGestureRecognizer(tap)
        tap.delegate = self

        titleLabel.text = rant!.valueForKey("title") as? String
        bodyLabel.text = rant!.valueForKey("body") as? String
        let acc = rant!.valueForKey("account") as? Account
        usernameLabel.text = acc!.user
        
        if let score = rant!.valueForKey("score"){
            scoreLabel.text = "\(score)"
        }
        
        if let comments = rant!.comment {
            var commentsArray:[Comment] = Array(comments) as! [Comment]
            commentsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
            
            if comments.count > 0 {
                let comment1 = commentsArray[0]
                guard let user1 = comment1.account?.user! else { return }
                guard let body1 = comment1.body else { return }
                sampleComment1.text = "\(user1): \(body1)"
            }
            else{
                sampleComment1.text = ""
            }
            
            if comments.count > 1 {
                let comment2 = commentsArray[1]
                guard let user2 = comment2.account?.user! else { return }
                guard let body2 = comment2.body else { return }
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
        
        
        if let solutions = rant!.solution {
            var solutionsArray:[Solution] = Array(solutions) as! [Solution]
            solutionsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
            
            if solutions.count > 0 {
                let solutions1 = solutionsArray[0]
                guard let user1 = solutions1.account?.user! else { return }
                guard let body1 = solutions1.title else { return }
                sampleSolution1.text = "\(user1): \(body1)"
            }
            else{
                sampleSolution1.text = ""
            }
            
            if solutions.count > 1 {
                let solutions2 = solutionsArray[1]
                guard let user2 = solutions2.account?.user! else { return }
                guard let body2 = solutions2.title else { return }
                sampleSolution2.text = "\(user2): \(body2)"
            }
            else{
                sampleSolution2.text = ""
            }
        }
        else{
            sampleSolution1.text = ""
            sampleSolution2.text = ""
        }

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
        
        alert.addAction(UIAlertAction(title: "Solution", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("addSolutionSegue", sender: self)
        }))
        
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

        let existingFavorites = account.mutableSetValueForKey("favorites").containsObject(rant!)
        let favorites = account.mutableSetValueForKey("favorites")
        
        if !existingFavorites {
            favorites.addObject(rant!)
        } else {
            favorites.removeObject(rant!)
        }
        
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
        
        if segue.identifier == "addSolutionSegue",
            let asvc = segue.destinationViewController as? AddSolutionViewController{
                asvc.rant = rant
        }
        
        if segue.identifier == "addCommentSegue",
            let acvc = segue.destinationViewController as? AddCommentViewController{
            acvc.rant = rant
        }
        
        if segue.identifier == "solutionsSegue",
            let stvc = segue.destinationViewController as? SolutionsTableViewController{
                stvc.rant = rant
        }
    
        if segue.identifier == "editRantSegue",
            let arvc = segue.destinationViewController as? AddRantViewController{
            arvc.header = "Edit Rant"
            arvc.titleText = titleLabel.text
            arvc.body = bodyLabel.text
            arvc.editRant = rant
        }
        
        
        if segue.identifier == "otherUserProfileSegue",
            let opvc = segue.destinationViewController as? ProfileViewController{
                opvc.usernameFromRant = usernameLabel.text
        }

        
    }
 

}
