//
//  MoneyViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/23/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit
import Parse

class MoneyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var amountText: UITextField!
    
    @IBOutlet var balanceLabel: UILabel!
    @IBAction func confirmButton(sender: UIButton) {
        amountText.resignFirstResponder()
        var amountToBeAdded = (amountText.text as NSString).doubleValue
        moneyBalance += amountToBeAdded
        println(moneyBalance)
        balanceLabel.text = "$" + String(format:"%.2f", moneyBalance)
        balanceLabel.sizeToFit()
        amountText.text = "";
        var queryTasks = PFQuery(className: "Tasks")
        queryTasks.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                if objects?.count == 0 {
                    println("No objects")
                    var newTask = PFObject(className:"Tasks")
                    newTask["moneyAvailable"] = moneyBalance
                    newTask["parent"] = userID
                    newTask["children"] = "shrey"
                    newTask.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            // The object has been saved.
                            println("Added object")
                        } else {
                            // There was a problem, check error.description
                            println("Error Adding")
                        }
                    }
                } else {
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects { //TODO: Add for a specific child
                            object["moneyAvailable"] = moneyBalance
                            object.saveInBackground()
                        }
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        amountText.delegate = self
        amountText.keyboardType = .DecimalPad;
        balanceLabel.text = "$" + String(format:"%.2f", moneyBalance)
        balanceLabel.sizeToFit()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
