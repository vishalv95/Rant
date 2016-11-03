//
//  HomeFeedTableViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/18/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class HomeFeedTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, TagAction {
    
    let cellIdentifier = "homeFeedCell"
    var rants = [Rant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        rants = retrieveRants()
        self.tableView.rowHeight = 75
        refreshControl = UIRefreshControl()
//        self.refreshControl?.addTarget(self, action: #selector(HomeFeedTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if !isUserLoggedIn {
            self.performSegueWithIdentifier("loginView", sender: self)
        }
        
    }
    
    func sendTag(tag: String) {
        var allRants:[Rant] = retrieveRants()
        var filteredRants = [Rant]()
        for i in 0..<(allRants.count){
            let rantTag = allRants[i].valueForKey("tags") as? String

            if rantTag == tag{
                filteredRants.append(allRants[i])
            }
        }
        
        rants = filteredRants
        tableView.reloadData()
    }
      
    func refresh(sender:AnyObject) {
        rants = retrieveRants()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HomeFeedCell
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "categorySegue" {
            let vc = segue.destinationViewController as! TagTableViewController
            vc.tagAction = self
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
        }
        
        
        if segue.identifier == "expandRantSegue",
            let index = tableView.indexPathForSelectedRow?.row,
            let ervc = segue.destinationViewController as? ExpandedRantViewController
        {
            ervc.rant = rants[index]
        }
        
    }

    
}