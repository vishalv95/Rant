//
//  SettingsViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/20/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBAction func logoutPressed(sender: AnyObject) {
        if let _ = FBSDKAccessToken.currentAccessToken() {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        if (GIDSignIn.sharedInstance().currentUser != nil) {
            GIDSignIn.sharedInstance().signOut()
        }
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("logoutSegue", sender: self);
    }

    @IBAction func clearCoreDataAction(sender: AnyObject) {
        clearRantCoreData()
    }
    
    
    @IBAction func clearUserDefaultsAction(sender: AnyObject) {
    
    }
}
