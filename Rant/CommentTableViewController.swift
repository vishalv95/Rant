//
//  CommentTableViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/27/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData


class CommentTableViewController: UITableViewController {
    var rant:Rant? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let cellIdentifier = "commentCellIdentifier"

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rant!.comment!.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CommentTableViewCell
        var commentsArray:[Comment] = Array(rant!.comment!) as! [Comment]
        commentsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
        
        let acc = commentsArray[indexPath.row].valueForKey("account") as? Account
        commentCell.usernameLabel?.text = acc!.user
        commentCell.commentBodyTextView?.text = commentsArray[indexPath.row].valueForKey("body") as? String
        return commentCell
    }
}
