//
//  RantTableCell.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/29/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class RantTableCell: UITableViewCell {

    @IBOutlet var view: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
}
