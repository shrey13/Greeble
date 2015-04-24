//
//  PARENTViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/23/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit
import Parse

var moneyBalance:Double = 10
var currentUser = PFUser.currentUser()
var userID:String = currentUser!.objectForKey("username") as! String

class ParentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
    UISearchBarDelegate{
    
    var pending = true
    var data = [String]()
    var completedTasks = [String]()
    var pendingTasks = [String]()
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tasksTable: UITableView!
    @IBOutlet var balanceLabel: UIBarButtonItem!
    
    @IBAction func tableType(sender: AnyObject) {
        if pending {
            pending = false
            data = completedTasks
            tasksTable.reloadData()
        } else {
            pending = true
            data = pendingTasks
            tasksTable.reloadData()
        }
    }
    var searchActive : Bool = false
    
    var filtered:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasksTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        

//        let tasksObject = PFObject(className: "Taks")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }

        var queryTasks = PFQuery(className: "Tasks")
        queryTasks.whereKey("parent", equalTo:userID)
        queryTasks.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores in parentView")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        if let tasksPending = object.objectForKey("pendingTasks") as? [String] {
                            self.pendingTasks = tasksPending
                        }
                        
                        if let balance = object.objectForKey("moneyAvailable") as? Double {
                            moneyBalance = balance
                            self.balanceLabel.title = "$" + String(format:"%.2f", moneyBalance)
                        }
                        
                        if let tasksCompleted = object.objectForKey("completedTasks") as? [String] {
                            self.completedTasks = tasksCompleted
                        }
                        self.data = self.pendingTasks
                        self.tasksTable.reloadData()
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
        }
            
            
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
        // Do any additional setup after loading the view.
        tasksTable.delegate = self
        tasksTable.dataSource = self
        searchBar.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tasksTable.reloadData()
    }
    
    func tableView(tasksTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(tasksTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tasksTable.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
    func tableView(tasksTable: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        tasksTable.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
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
