//
//  TagTableViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//
import UIKit

class TagTableViewController: UITableViewController {
    
    let tags = ["Food", "Games", "Art", "Business", "Technology", "Misc"]
    var tagAction: TagAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    let cellIdentifier = "tagCellIdentifier"
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tagCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TagCell
        //        cell.usernameLabel?.text = rants[indexPath.row].valueForKey("user") as? String
    
        tagCell.tagLabel?.text = tags[indexPath.row]
        return tagCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        tagAction.sendTag(tags[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
}
