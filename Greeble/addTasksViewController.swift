//
//  addTasksViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/23/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit
import Parse
class addTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tasksTable: UITableView!
    
    var data = ["Math", "History", "Sex Ed"]
    var selectedTasks:[String] = []
    var pendingTasks:[String] = []
    var searchActive : Bool = false
    var filtered:[String] = []
    
    
    @IBAction func done(sender: AnyObject) {
        println("Done Button")
        println(selectedTasks.count)
        if selectedTasks.count != 0 {
            pendingTasks += selectedTasks
            println("Done")
            var queryTasks = PFQuery(className: "Tasks")
            queryTasks.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    // The find succeeded.
                    if objects?.count == 0 {
                        println("No objects")
                        var newTask = PFObject(className:"Tasks")
                        newTask["pendingTasks"] = self.pendingTasks
                        newTask["parent"] = userID
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
                                object["pendingTasks"] = self.pendingTasks
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
        self.performSegueWithIdentifier("doneAddingSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tasksTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tasksTable.delegate = self
        tasksTable.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        
        
        
        var queryTasks = PFQuery(className: "Tasks")
        queryTasks.whereKey("parent", equalTo:userID)
        queryTasks.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                println("Retrieving")
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        if let tasksPending = object.objectForKey("pendingTasks") as? [String] {
                            self.pendingTasks = tasksPending
                        }
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
        }
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
        let cell: UITableViewCell = tasksTable.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedTasks.append(cell.textLabel!.text!)
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
            selectedTasks.removeAtIndex(find(selectedTasks, cell.textLabel!.text!)!)
        }
        //println(selectedTasks)
        tasksTable.deselectRowAtIndexPath(indexPath, animated: true)
        
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
