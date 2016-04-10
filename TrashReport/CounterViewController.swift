//
//  CounterViewController.swift
//  TrashReport
//
//  Created by Bryan Fullam on 4/6/16.
//  Copyright © 2016 Help Your Harbor. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class CounterViewController: UIViewController, CLLocationManagerDelegate {
    
    var trashType = ""
    var locValue:CLLocationCoordinate2D!
    var baseRef = Firebase(url:"https://glaring-fire-6068.firebaseio.com")
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLable: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitAction(sender: AnyObject) {
        if (Int(stepper.value) > 0)
        {
            //get location info
            let locationManage = CLLocationManager()
            
            locationManage.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManage.delegate = self
                locationManage.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManage.startUpdatingLocation()
            }
            func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                locValue = manager.location!.coordinate
            }
            
            //get date info
            let date = NSDate()
            
            //put info into structure
            let locRef = baseRef.childByAppendingPath("\(date)")
            let info =  ["trash_type": trashType,
                         "trash_count": Int(stepper.value).description,
                         "Trash_loc": "\(locValue)"]
            
            //add to firebase
            locRef.setValue(info, withCompletionBlock: {
                (error:NSError?, ref:Firebase!) in
                if( error != nil) {
                    print("Data failed")
                } else {
                    print("Data saved")
                    self.performSegueWithIdentifier("toReceipt", sender: sender)
                }
            })
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
//        print("Trash type selected: \(trashType)")
        
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
