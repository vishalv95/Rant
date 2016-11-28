//
//  FavoritesNavigationController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/20/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class FavoritesNavigationController: UINavigationController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.barTintColor = UIColor(red: 56/255.0, green: 52/255.0, blue: 91/255.0, alpha: 1)
    }
}
