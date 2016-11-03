//
//  ProfileViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/30/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var badge1: UIImageView!
    @IBOutlet weak var badge2: UIImageView!
    @IBOutlet weak var badge3: UIImageView!
    @IBOutlet weak var badge4: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBAction func editProfilePictureButtonPressed(sender: AnyObject) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.allowsEditing = false

        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    var rants = retrieveRantsForThisUser()
    let imagePicker = UIImagePickerController()
    var account:Account? = retrieveThisAccount()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if let prof = account?.profileImage {
            profileImage.image = UIImage(data:prof,scale:1.0)
        }
        usernameLabel.text = account!.user
        account = retrieveThisAccount()
        profileTableView.reloadData()
        badgeRender()

    }
    
    func badgeRender(){
//        TODO: Badges not appearing after threshold is met
        if account?.rant?.count < 5{
            badge1.hidden = true
        }
        else{
            badge1.hidden = false
        }
        var totalVotes:Int = 0
        for post in (account?.rant)! {
            let rant = post as! Rant
            totalVotes += Int(rant.upvotes!) - Int(rant.downvotes!)
        }
        
        if totalVotes < 10 {
            badge2.hidden = true
        }
        else{
            badge2.hidden = false
        }
        
        if account?.comment?.count < 5{
            badge3.hidden = true
        }
        else{
            badge3.hidden = false
        }

//        if account?.solution?.count < 5{
            badge4.hidden = true
//        }
        
//        else{
//            badge4.hidden = false
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("profileRantCellIdentifier", forIndexPath: indexPath) as! ProfileFeedCell
        cell.rant = rants[indexPath.row]
        cell.titleLabel?.text = rants[indexPath.row].valueForKey("title") as? String
        let acc = rants[indexPath.row].valueForKey("account") as? Account
        cell.usernameLabel?.text = acc?.user!
        
        if let upvotes = rants[indexPath.row].valueForKey("upvotes"){
            if let downvotes = rants[indexPath.row].valueForKey("downvotes"){
                let score = (upvotes as! Int) - (downvotes as! Int)
                cell.scoreLabel?.text = "\(score)"
            }
            else{
                cell.scoreLabel?.text = "0"
            }
        }
        else{
            cell.scoreLabel?.text = "0"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext

        profileImage.image = image
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 1.0)!)
        account?.profileImage = imageData
        
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
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profileExpandRantSegue",
            let index = profileTableView.indexPathForSelectedRow?.row,
            let ervc = segue.destinationViewController as? ExpandedRantViewController
        {
            ervc.rant = rants[index]
        }
    }
 

}
