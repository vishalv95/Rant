//
//  HomeFeedCell.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/18/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class HomeFeedCell: UITableViewCell {
    var rant:Rant? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
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
}
