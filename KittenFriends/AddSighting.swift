//
//  FirstViewController.swift
//  KittenFriends
//
//  Created by Mark Pleskac on 2/23/15.
//  Copyright (c) 2015 Mark Pleskac. All rights reserved.
//

import UIKit
import MapKit

class AddSighting: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    @IBOutlet var primaryColor: UITextField!
    @IBOutlet var addSightingMap: MKMapView!
    var locationManager:CLLocationManager!
    
    @IBAction func addSighting(sender: AnyObject) {
        var alert = UIAlertView(title: "Add Sighting", message: primaryColor.text, delegate: nil, cancelButtonTitle: "Cancel");
        
        alert.show();
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Dismiss keyboard
        primaryColor.delegate = self;
        
        // Get current location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Set location as map view location
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}