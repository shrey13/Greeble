//
//  ProbablityViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/24/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit

class ProbablityViewController: UIViewController {

    @IBOutlet var switchButton: UIButton!
    @IBOutlet var dontSwitchButton: UIButton!
    
    @IBOutlet var solutionText: UITextView!
    
    @IBAction func dontSwitchClick(sender: UIButton) {
        if (switchButton.titleColorForState(UIControlState.Normal) != UIColor.greenColor()){
            switchButton.setTitleColor(UIColor.greenColor(), forState:UIControlState.Normal)
            
            dontSwitchButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
        }
        else{
            switchButton.hidden = true
            dontSwitchButton.hidden = true
            solutionText.hidden = false;
        }

    }
    @IBAction func switchClick(sender: UIButton) {
        if (switchButton.titleColorForState(UIControlState.Normal) != UIColor.greenColor()){
        switchButton.setTitleColor(UIColor.greenColor(), forState:UIControlState.Normal)
            
            dontSwitchButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
        }
        else{
            switchButton.hidden = true
            dontSwitchButton.hidden = true
            solutionText.hidden = false;
        }
        
    }
    
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
