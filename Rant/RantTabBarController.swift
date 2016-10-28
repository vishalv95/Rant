//
//  RantTabBarController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/20/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class RantTabBarController: UITabBarController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.barTintColor = UIColor(red: 56/255.0, green: 52/255.0, blue: 91/255.0, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

    }
}
