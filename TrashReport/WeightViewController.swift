//
//  WeightViewController.swift
//  TrashReport
//
//  Created by Bryan Fullam on 4/6/16.
//  Copyright © 2016 Help Your Harbor. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController, UITextFieldDelegate {
    
    var trashType = ""
    
    @IBOutlet weak var inputWeight: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitAction(sender: AnyObject) {
        self.performSegueWithIdentifier("toReceipt", sender: sender)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let receiptVC = (segue.destinationViewController as! ReceiptViewController)
        receiptVC.trashType = trashType
        receiptVC.trashWeight = Int(inputWeight.text!)!.description
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = (inputWeight.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if let _ = Int(text) {
            // Text field converted to an Int
            submitButton.enabled = true
        } else {
            // Text field is not an Int
            submitButton.enabled = false
        }
        
        // Return true so the text field will be changed
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trash Weight"
        submitButton.enabled = false
        inputWeight.delegate = self
        inputWeight.keyboardType = .NumberPad
        
        print("Trash type selected: \(trashType)") //debugging
        
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
