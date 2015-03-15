//
//  FirstViewController.swift
//  KittenFriends
//
//  Created by Mark Pleskac on 2/23/15.
//  Copyright (c) 2015 Mark Pleskac. All rights reserved.
//

import UIKit
import MapKit

class AddSighting: UIViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var primaryColor: UITextField!
    @IBOutlet var addSightingMap: MKMapView!
    var locationManager:CLLocationManager!
    var sightingAnnotation:MKPointAnnotation!
    
    @IBAction func addSighting(sender: AnyObject) {
        var alert = UIAlertView(title: "Add Sighting", message: primaryColor.text, delegate: nil, cancelButtonTitle: "Cancel");
        
        alert.show();
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return false;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        primaryColor.resignFirstResponder()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        
        self.addSightingMap.setRegion(region, animated: true)
        
        if(sightingAnnotation == nil && addSightingMap.delegate != nil){
            sightingAnnotation = MKPointAnnotation()
            sightingAnnotation.coordinate = location.coordinate
            sightingAnnotation.title = "The cat was here!"
            
            addSightingMap.addAnnotation(sightingAnnotation)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        primaryColor.delegate = self;
        addSightingMap.delegate = self;
        
        setUserLocation();
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if(annotation is MKUserLocation){
            return nil;
        }
        
        let identifyer = "SightingPin"
        
        if annotation.isKindOfClass(MKPointAnnotation) {
            var customAnnotation = annotation as? MKPointAnnotation
            mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifyer) as MKPinAnnotationView!
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifyer);
                annotationView.animatesDrop = true
                annotationView.draggable = true
            } else {
                annotationView.annotation = annotation;
            }
            
            return annotationView
        } else {
            return nil
        }
    }
    
    func setUserLocation(){
        // Get current location
        if(locationManager == nil){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            // Set location as map view location
            addSightingMap.showsUserLocation = false
        }
    }
    
    override func applicationFinishedRestoringState() {
        setUserLocation();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}