//
//  SolutionViewController.swift
//  Rant
//
//  Created by Timmy Gianitsos on 11/3/16.
//  Copyright © 2016 group4. All rights reserved.
//

import Foundation
import UIKit

class SolutionViewController: UIViewController {
    
    var solution: Solution!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var sloganText: UITextView!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var dislikes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var contributions: UILabel!
    @IBOutlet weak var contributors: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        titleText.text! = solution.title!
        sloganText.text! = solution.slogan!
        summaryText.text! = solution.summary!
        likes.text! = String(solution.likes!)
        dislikes.text! = String(solution.dislikes!)
        comments.text! = String(solution.comments!.count)
        contributions.text! = String(solution.contributions!)
        contributors.text! = String(solution.contributors!)
    }
}