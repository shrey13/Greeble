//
//  MoneyViewController.swift
//  Greeble
//
//  Created by Sudhanshu Nath Mishra on 4/23/15.
//  Copyright (c) 2015 Greeblers. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var amountText: UITextField!
    
    @IBOutlet var confirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        confirmButton.enabled = false
        amountText.delegate = self
        amountText.keyboardType = .NumberPad;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = (amountText.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if let intVal = text.toInt() {
            // Text field converted to an Int
            confirmButton.enabled = true
        } else {
            // Text field is not an Int
            confirmButton.enabled = false
        }
        
        // Return true so the text field will be changed
        return true
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
