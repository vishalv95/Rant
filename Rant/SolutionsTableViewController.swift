//
//  SolutionsTableViewController.swift
//  Rant
//
//  Created by Alana Layton on 11/25/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class SolutionsTableViewController: UITableViewController {

    var rant:Rant? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let cellIdentifier = "solutionCellIdentifier"
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rant!.solution!.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let solutionCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SolutionsTableViewCell
        var solutionsArray:[Solution] = Array(rant!.solution!) as! [Solution]
        solutionsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
        
        let acc = solutionsArray[indexPath.row].valueForKey("account") as? Account
        solutionCell.usernameLabel?.text = acc!.user
        solutionCell.bodyTextField?.text = solutionsArray[indexPath.row].valueForKey("body") as? String
        return solutionCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "expandSolutionSegue",
            let index = tableView.indexPathForSelectedRow?.row,
            let esvc = segue.destinationViewController as? ExpandedSolutionViewController
        {
            var solutionsArray:[Solution] = Array(rant!.solution!) as! [Solution]
            solutionsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
            esvc.solution = solutionsArray[index]
        }
        
    }


}
