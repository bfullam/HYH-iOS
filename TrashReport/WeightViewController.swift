//
//  WeightViewController.swift
//  TrashReport
//
//  Created by Bryan Fullam on 4/6/16.
//  Copyright © 2016 Help Your Harbor. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class WeightViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var trashType = ""
    var locValue:CLLocationCoordinate2D!
    var locationManager:CLLocationManager!
    var baseRef = Firebase(url:"https://glaring-fire-6068.firebaseio.com")
    
    @IBOutlet weak var inputWeight: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitAction(sender: AnyObject) {
        
        //get date info
        let date = NSDate()
        
        //put info into structure
        let locRef = baseRef.childByAppendingPath("\(date)")
        let info =  ["trash_type": trashType,
                     "trash_weight": Int(inputWeight.text!)!.description,
                     "Trash_lat": locValue.latitude,
                     "Trash_long": locValue.longitude]
        
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

}
