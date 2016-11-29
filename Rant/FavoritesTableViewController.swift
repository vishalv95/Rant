//
//  FavoritesTableViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/28/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    var rants = retrieveFavoritesForThisUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 75
    }
    
    override func viewWillAppear(animated: Bool) {
        rants = retrieveFavoritesForThisUser()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteFeedCell", forIndexPath: indexPath) as! FavoriteTableCell
        
        cell.rant = rants[indexPath.row]
        cell.titleLabel?.text = rants[indexPath.row].valueForKey("title") as? String
        let acc = rants[indexPath.row].valueForKey("account") as? Account
        cell.usernameLabel?.text = acc?.user!
        
        if let score = rants[indexPath.row].valueForKey("score"){
            cell.scoreLabel?.text = "\(score)"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "favExpandRantSegue",
            let index = tableView.indexPathForSelectedRow?.row,
            let ervc = segue.destinationViewController as? ExpandedRantViewController
        {
            let rantsArray = Array(rants)
            ervc.rant = rantsArray[index]
        }
        
    }

}
