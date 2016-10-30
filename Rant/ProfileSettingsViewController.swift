//
//  ProfileSettingsViewController.swift
//  Rant
//
//  Created by Vishal Vusirikala on 10/30/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let user = NSUserDefaults.standardUserDefaults()
    
        if usernameTextField.text != "" && usernameTextField.text != "New Username"{
            account?.user = usernameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            user.setObject(usernameTextField.text!, forKey:"username")
        }
        
        if cityTextField.text != "" && cityTextField.text != "New City"{
            account?.city = cityTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            user.setObject(cityTextField.text!, forKey:"city")
            
        }
        
        if stateTextField.text != "" && stateTextField.text != "New State"{
            account?.state = stateTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            user.setObject(stateTextField.text!, forKey: "state")
        }
        
        // Save changes
        user.synchronize();
        do {
            try managedContext.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
    var account = retrieveThisAccount()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        account = retrieveThisAccount()
        usernameLabel.text = account?.user
        if let city = account?.city{
            if let state = account?.state{
                locationLabel.text = "\(city), \(state)"

            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
