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
    var baseRef = Firebase(url:"https://glaring-fire-6068.firebaseio.com")
    
    @IBOutlet weak var inputWeight: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitAction(sender: AnyObject) {
        
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
        
        var locRef = baseRef.childByAppendingPath("\(locValue)")
        let info =  ["trash_type": trashType,
                     "trash_weight": Int(inputWeight.text!)!.description]
        
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
        
//        print("Trash type selected: \(trashType)") //debugging
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
