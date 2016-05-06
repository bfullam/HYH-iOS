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
    var locationManager:CLLocationManager!
    var baseRef = Firebase(url:"https://glaring-fire-6068.firebaseio.com")
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLable: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitAction(sender: AnyObject) {
        if (Int(stepper.value) > 0)
        {
            //get date info
            let date = NSDate()
            
            //put info into structure
            let dateRef = baseRef.childByAppendingPath("\(date)")
            let info =  ["trash_type": trashType,
                         "trash_count": Int(stepper.value).description,
                         "Trash_lat": locValue.latitude,
                         "Trash_long": locValue.longitude]
            
            //add to firebase
            dateRef.setValue(info, withCompletionBlock: {
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let receiptVC = (segue.destinationViewController as! ReceiptViewController)
        receiptVC.trashType = trashType
        receiptVC.trashCount = Int(valueLable.text!)!.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trash Count"
//        print("Trash type selected: \(trashType)")
        
        stepper.autorepeat = true
        submitButton.enabled = false
        
        //get location info
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if (authorizationStatus == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestWhenInUseAuthorization()
        } else if (authorizationStatus == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locValue = manager.location!.coordinate
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
