//
//  RegisterViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/19/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
   
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatedPasswordTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        let username = usernameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let userPassword = passwordTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let userRepeatPassword = repeatedPasswordTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let city = cityTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let state = stateTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // Check for empty fields
        if(username.isEmpty || userPassword.isEmpty || userRepeatPassword.isEmpty)
        {
            // Display alert message
            let alert:UIAlertController = UIAlertController(title: "Alert", message: "All Fields are required", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return;
        }
        
        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            let alert:UIAlertController = UIAlertController(title: "Alert", message: "Passwords do not match", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return;
            
        }
        
        
        // Store data
        let user = NSUserDefaults.standardUserDefaults()
        user.setObject(username, forKey:"username")
        user.setObject(userPassword, forKey:"password")
        user.setObject(city, forKey:"city")
        user.setObject(state, forKey: "state")
        
        //store core data
        storeAccount(username, password:userPassword, city:city, state:state)

        NSUserDefaults.standardUserDefaults().setBool(true,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        performSegueWithIdentifier("registerSignInSegue", sender: self)
        
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
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//      
//        
//        
//    }

    


}
