//
//  LoginViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if let usernameStored = NSUserDefaults.standardUserDefaults().stringForKey("username"){
            if let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("password"){
               
                if username == usernameStored{
                    if password == userPasswordStored{
                        // Login is successfull
                        NSUserDefaults.standardUserDefaults().setBool(true,forKey:"isUserLoggedIn");
                        NSUserDefaults.standardUserDefaults().synchronize();
                        
                        self.dismissViewControllerAnimated(true, completion:nil);
                    }
                    
                    else {
                        let alert:UIAlertController = UIAlertController(title: "Alert", message: "Password is incorrect", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }

                }
                
                else {
                    let alert:UIAlertController = UIAlertController(title: "Alert", message: "Username is incorrect", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
