//
//  SolutionInfoViewcontroller.swift
//  Rant
//
//  Created by Timmy Gianitsos on 11/28/16.
//  Copyright © 2016 group4. All rights reserved.
//

import Foundation
import UIKit

class SolutionInfoViewController: UIViewController {
    
    var solution: Solution!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var sloganText: UITextView!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var contributions: UILabel!
    @IBOutlet weak var contributors: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        titleText.text! = solution.title!
        sloganText.text! = solution.slogan!
        summaryText.text! = solution.summary!
        contributions.text! = String(solution.contributions!)
        contributors.text! = String(solution.contributors!)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "timelineSegue",
            let esvc = segue.destinationViewController as? ExpandedSolutionViewController
        {
            esvc.solution = self.solution
        }
        
    }

    
}