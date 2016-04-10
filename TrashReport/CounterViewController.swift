//
//  CounterViewController.swift
//  TrashReport
//
//  Created by Bryan Fullam on 4/6/16.
//  Copyright © 2016 Help Your Harbor. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    
    var trashType = ""
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLable: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitAction(sender: AnyObject) {
        if (Int(stepper.value) > 0)
        {
            self.performSegueWithIdentifier("toReceipt", sender: sender)
        }
    }
    
    @IBAction func stepperValueChanged(sender: AnyObject) {
        valueLable.text = Int(stepper.value).description
        
        if (Int(stepper.value) > 0)
        {
            submitButton.enabled = true;
        } else {
            submitButton.enabled = false;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trash Count"
        print("Trash type selected: \(trashType)")
        
        stepper.autorepeat = true
        submitButton.enabled = false
        
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
