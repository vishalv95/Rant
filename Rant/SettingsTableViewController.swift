//
//  SettingsTableViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/30/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        if let _ = FBSDKAccessToken.currentAccessToken() {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        GIDSignIn.sharedInstance().signOut()
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("logoutSegue", sender: self);
    }
    
    @IBAction func clearCoreDataButtonPressed(sender: AnyObject) {
        clearRantCoreData()
    }

    @IBAction func clearUserDefaultsButtonPressed(sender: AnyObject) {
    }

    @IBOutlet weak var clearUserDefaultsButtonPressed: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 243.0/255, green: 243.0/255, blue: 243.0/255, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        let account = retrieveThisAccount()
        usernameLabel.text = account?.user
        if let city = account?.city{
            if let state = account?.state{
                locationLabel.text = "\(city), \(state)"
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
