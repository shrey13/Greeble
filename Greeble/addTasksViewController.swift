//
//  addTasksViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/23/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit

class addTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tasksTable: UITableView!
    
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var searchActive : Bool = false
    var filtered:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tasksTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tasksTable.delegate = self
        tasksTable.dataSource = self
        searchBar.delegate = self

        // Do any additional setup after loading the view.
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
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
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
