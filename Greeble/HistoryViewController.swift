//
//  HistoryViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/24/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit
import Parse
class HistoryViewController: UIViewController {

    @IBOutlet var solutionText: UITextView!
    @IBOutlet var chickenButton: UIButton!
    @IBOutlet var eggButton: UIButton!
    
    @IBAction func chickenClicked(sender: UIButton) {
        if (chickenButton.titleColorForState(UIControlState.Normal) != UIColor.redColor()){
            chickenButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
            
            eggButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
            
            var currentUser = PFUser.currentUser()
            var userID:String = currentUser!.objectForKey("username") as! String
            var queryTasks = PFQuery(className: "Tasks")
            queryTasks.whereKey("children", equalTo:userID)
            queryTasks.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    // The find succeeded.
                    println("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            
                            if let tasksPending = object.objectForKey("pendingTasks") as? [String] {
                                var pendingTasks = tasksPending
                                pendingTasks.removeAtIndex(find(pendingTasks, "History")!)
                                object["pendingTasks"] = pendingTasks
                            }
                            
                            //                            if let balance = object.objectForKey("moneyAvailable") as? Double {
                            //                                moneyBalance = balance
                            //                                self.balanceLabel.title = "$" + String(format:"%.2f", moneyBalance)
                            //                            }
                            
                            if let tasksCompleted = object.objectForKey("completedTasks") as? [String] {
                                var completedTasks = tasksCompleted
                                completedTasks.append("History")
                                object["completedTasks"] = completedTasks
                            } else {
                                object["completedTasks"] = ["History"]
                            }
                            object.saveInBackground()
                        }
                    }
                } else {
                    // Log details of the failure
                    println("Error: \(error) \(error!.userInfo!)")
                }
            }
        }
        else{
            chickenButton.hidden = true
            eggButton.hidden = true
            solutionText.hidden = false;
        }

    }

    @IBAction func eggClick(sender: UIButton) {
        if (chickenButton.titleColorForState(UIControlState.Normal) != UIColor.redColor()){
            chickenButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
            
            eggButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
            
            var currentUser = PFUser.currentUser()
            var userID:String = currentUser!.objectForKey("username") as! String
            var queryTasks = PFQuery(className: "Tasks")
            queryTasks.whereKey("children", equalTo:userID)
            queryTasks.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    // The find succeeded.
                    println("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            
                            if let tasksPending = object.objectForKey("pendingTasks") as? [String] {
                                var pendingTasks = tasksPending
                                pendingTasks.removeAtIndex(find(pendingTasks, "History")!)
                                object["pendingTasks"] = pendingTasks
                            }
                            
                            //                            if let balance = object.objectForKey("moneyAvailable") as? Double {
                            //                                moneyBalance = balance
                            //                                self.balanceLabel.title = "$" + String(format:"%.2f", moneyBalance)
                            //                            }
                            
                            if let tasksCompleted = object.objectForKey("completedTasks") as? [String] {
                                var completedTasks = tasksCompleted
                                completedTasks.append("History")
                                object["completedTasks"] = completedTasks
                            } else {
                                object["completedTasks"] = ["History"]
                            }
                            object.saveInBackground()
                        }
                    }
                } else {
                    // Log details of the failure
                    println("Error: \(error) \(error!.userInfo!)")
                }
            }
        }
        else{
            chickenButton.hidden = true
            eggButton.hidden = true
            solutionText.hidden = false;
        }
    }
    
    @IBOutlet var eggClick: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        solutionText.hidden = true;


        // Do any additional setup after loading the view.
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
