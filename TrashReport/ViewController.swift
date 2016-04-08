//
//  ViewController.swift
//  TrashReport
//
//  Created by Bryan Fullam on 4/6/16.
//  Copyright © 2016 Help Your Harbor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var trashType = ""
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var currentTrash: String
        switch indexPath.row {
        case 0:
            currentTrash = "Plastic"
        case 1:
            currentTrash = "Styrofoam"
        case 2:
            currentTrash = "Paper"
        case 3:
            currentTrash = "Glass"
        case 4:
            currentTrash = "Metal"
        case 5:
            currentTrash = "Cigarettes"
        case 6:
            currentTrash = "Fishing Gear"
        case 7:
            currentTrash = "Ball"
        case 8:
            currentTrash = "Cork"
        case 9:
            currentTrash = "Rubber"
        case 10:
            currentTrash = "other"
        default:
            currentTrash = ""
        }
        cell.textLabel!.text = currentTrash
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected row: \(indexPath.row)") //debugging
        
        //business logic
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        trashType = (cell?.textLabel?.text)!
        
        switch indexPath.row{
        case 0, 3, 4, 7, 9:
            self.performSegueWithIdentifier("toWeight", sender: indexPath)
        case 1, 2, 5, 6, 8, 10:
            self.performSegueWithIdentifier("toCounter", sender: indexPath)
        default:
            print("ERROR: unknown trash type selected")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toCounter")
        {
            let counterVC = (segue.destinationViewController as! CounterViewController)
            counterVC.trashType = trashType
        }
        else if (segue.identifier == "toWeight")
        {
            let weightVC = (segue.destinationViewController as! WeightViewController)
            weightVC.trashType = trashType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trash Type"
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

