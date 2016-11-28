//
//  ProfileNavigationController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/30/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class ProfileNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.barTintColor = UIColor(red: 56/255.0, green: 52/255.0, blue: 91/255.0, alpha: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
