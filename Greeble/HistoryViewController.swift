//
//  HistoryViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/24/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var solutionText: UITextView!
    @IBOutlet var chickenButton: UIButton!
    @IBOutlet var eggButton: UIButton!
    
    @IBAction func chickenClicked(sender: UIButton) {
        if (chickenButton.titleColorForState(UIControlState.Normal) != UIColor.redColor()){
            chickenButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
            
            eggButton.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
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
