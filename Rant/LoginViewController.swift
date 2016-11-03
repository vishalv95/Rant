//
//  LoginViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let err = error {
            print(error)
        }
        else {
            let username = GIDSignIn.sharedInstance().currentUser.profile.email.componentsSeparatedByString("@")[0]
            let userPassword = GIDSignIn.sharedInstance().currentUser.profile.name
            let city = ""
            let state = ""
            self.fbLogIn(username, userPassword: userPassword, city: city, state: state)
            
        }
    }
    
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        
    }
    

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            print("theres an error here, uh oh!")
        } else {
            returnUserData()
        }

    }
    
    func returnUserData() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in

            if requestError != nil {
                print("Error: \(requestError)")
                return
            }
            
            let email = user["email"] as? String
            let firstName = user["first_name"] as? String
            let lastName = user["last_name"] as? String
            
            let username = email?.componentsSeparatedByString("@")[0]   //grab before @ sign probably
            let userPassword = "\(firstName!) \(lastName!)"
            let city = ""
            let state = ""
            self.fbLogIn(username!, userPassword: userPassword, city: city, state: state)
            var pictureUrl = ""
            
            if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                pictureUrl = url
            }
            
        })
    }
    
    func fbLogIn(username:String, userPassword:String, city:String, state:String) {
        
        // Store data
        let user = NSUserDefaults.standardUserDefaults()
        user.setObject(username, forKey:"username")
        user.setObject(userPassword, forKey:"password")
        user.setObject(city, forKey:"city")
        user.setObject(state, forKey: "state")
        
        //store core data
        storeAccount(username, password:userPassword, city:city, state:state)
        print("do i get here")
        NSUserDefaults.standardUserDefaults().setBool(true,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.dismissViewControllerAnimated(true, completion:nil);

    }
    
    func storeAccount(user:String, password:String, city:String, state:String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entityForName("Account", inManagedObjectContext: managedContext)
        let account = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        // Set the attribute values
        account.setValue(user, forKey: "user")
        account.setValue(password, forKey: "password")
        account.setValue(city, forKey: "city")
        account.setValue(state, forKey: "state")
        
        
        // Commit the changes
        do {
            try managedContext.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    
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
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "729261000931-plorrjmkj2k4l87904jj9gutg6dje4b0.apps.googleusercontent.com"


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
