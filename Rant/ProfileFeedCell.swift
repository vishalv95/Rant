//
//  ProfileTableViewCell.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/30/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class ProfileFeedCell: UITableViewCell {
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
        
        if self.downVoteButton.enabled{
            self.upVoteButton.enabled = false
        }
            
        else {
            self.upVoteButton.enabled = true
        }
        self.downVoteButton.enabled = true
        
    }
    
    @IBAction func downVoteButtonPressed(sender: AnyObject) {
        let newScore = Int(scoreLabel.text!)! - 1
        scoreLabel.text = "\(Int(newScore))"
        rant!.downVote()
        
        if self.upVoteButton.enabled{
            self.downVoteButton.enabled = false
        }
            
        else {
            self.downVoteButton.enabled = true
        }
        self.upVoteButton.enabled = true
        
        
    }
}
