//
//  ReceiptViewController.swift
//  TrashReport
//
//  Created by Bryan Fullam on 4/9/16.
//  Copyright © 2016 Help Your Harbor. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    var trashType = ""
    var trashWeight = ""
    var trashCount = ""

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBAction func returnAction(sender: AnyObject) {
        self.performSegueWithIdentifier("toHome", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Receipt"
        self.navigationItem.setHidesBackButton(true, animated: true)
        typeLabel.text = trashType
        if(trashWeight != "")
        {
            weightLabel.text = trashWeight
        }
        if(trashCount != "")
        {
            countLabel.text = trashCount
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
