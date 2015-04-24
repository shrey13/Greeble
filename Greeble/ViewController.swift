//
//  ViewController.swift
//  Greeble
//
//  Created by Shreyash Agrawal on 4/22/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit
import Parse
class ViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayErrorAlert(title: String, error: String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        var errorMessage = ""
        
        if username.text == "" || password.text == "" {
            errorMessage = "Please enter a username and password"
        }
        // Add username and password restrictions here!
        
        if errorMessage != "" { //If there's an error
            displayErrorAlert("Error", error: errorMessage)
        } else {
            
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
                (user: PFUser?, logInError: NSError?) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if logInError == nil {
                    // Do stuff after successful login.
                    println("Logged In")
                    if let isParent = user!.objectForKey("parent")! as? Bool {
                        if isParent {
                            self.performSegueWithIdentifier("parentSegue", sender: nil)
                        } else {
                            self.performSegueWithIdentifier("childSegue", sender: nil)
                        }
                    }
                } else {
                    // The login failed. Check error to see why.
                    if let errorString = logInError!.userInfo?["error"] as? NSString {
                        errorMessage = errorString as String
                    } else {
                        errorMessage = "Please try again later."
                    }
                    // Show the errorString somewhere and let the user try again.
                    self.displayErrorAlert("Error Logging In", error: errorMessage.capitalizedString)
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }
        
//        var query = PFQuery(className: "TestObject")
//        query.getObjectInBackgroundWithId("CBPVVXDJud") {
//            (success: PFObject?, error: NSError?) -> Void in
//            if error == nil {
//                let s = success!
//                println(s["foo"])
//                s["foo"] = "bars"
//                s.saveInBackground()
//            } else{
//                println("Object has been saved.")
//            }
//        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

