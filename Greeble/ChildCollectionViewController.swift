import UIKit
import Parse
let reuseIdentifier = "collCell"

class ChildCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    var data = [String]()
    var pendingTasks = [String]()
    var completedTasks = [String]()
    var pending = true
    var moneyEarned = 0.00
    
    @IBOutlet var moneyEarnedLabel: UIBarButtonItem!
    @IBAction func taskType(sender: AnyObject) {
        if pending {
            pending = false
            data = completedTasks
            self.collectionView?.reloadData()
        } else {
            pending = true
            data = pendingTasks
            self.collectionView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                            self.pendingTasks = tasksPending
                        }
                        
                        if let balance = object.objectForKey("moneyEarned") as? Double {
                            self.moneyEarned = balance
                        }
                        
                        if let tasksCompleted = object.objectForKey("completedTasks") as? [String] {
                            self.completedTasks = tasksCompleted
                        }
//                        self.data = self.pendingTasks
//                        self.tasksTable.reloadData()
                        self.moneyEarnedLabel.title = "$" + String(format:"%.2f", self.moneyEarned)
                        self.data = self.pendingTasks
                        self.collectionView?.reloadData()
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
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if pending {
            return self.pendingTasks.count
        } else {
            return self.completedTasks.count
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        println(cell.description)
        cell.title.text = self.data[indexPath.row]
        var imageExtension = "History1.jpg"
        let random = Int(arc4random_uniform(3))+1
        if cell.title.text == "Math" {
            imageExtension = "Math\(random).jpg"
        } else {
            imageExtension = "History\(random).jpg"
        }
        cell.pinImage.image = UIImage(named: imageExtension)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            return CGSize(width: 170, height: 300)
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.title.text = self.pendingTasks[indexPath.row]
        if cell.title.text == "Math" {
            self.performSegueWithIdentifier("probabilitySegue", sender: nil)
        } else {
            self.performSegueWithIdentifier("historySegue", sender: nil)
        }
        //println(selectedTasks)
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
}