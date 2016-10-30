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
        let rantsArray = Array(rants)
        cell.rant = rantsArray[indexPath.row] as? Rant
        cell.titleLabel?.text = rantsArray[indexPath.row].valueForKey("title") as? String
        let acc = rantsArray[indexPath.row].valueForKey("account") as? Account
        cell.usernameLabel?.text = acc?.user!
        
        if let upvotes = rantsArray[indexPath.row].valueForKey("upvotes"){
            if let downvotes = rantsArray[indexPath.row].valueForKey("downvotes"){
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
    
    
    
}
