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
    var sightingAnnotation:SightingAnnotation!
    
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
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.addSightingMap.setRegion(region, animated: true)
        
        if(sightingAnnotation == nil && addSightingMap.delegate != nil){
            sightingAnnotation = SightingAnnotation(coordinate: location.coordinate)
            //sightingAnnotation.title = "TEST"
            
            addSightingMap.addAnnotation(sightingAnnotation)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Dismiss keyboard
        primaryColor.delegate = self;
        addSightingMap.delegate = self;
        
        setUserLocation();
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.Starting
        {
            view.dragState = MKAnnotationViewDragState.Dragging
        }
        else if newState == MKAnnotationViewDragState.Ending || newState == MKAnnotationViewDragState.Canceling
        {
            view.dragState = MKAnnotationViewDragState.None;
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if(annotation is MKUserLocation){
            // ignore user loctaion.... not sure if i want this
            return nil;
        }
        
        if (annotation.isKindOfClass(SightingAnnotation)) {
            var customAnnotation = annotation as? SightingAnnotation
            mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("Custom") as MKPinAnnotationView!
            
            if (annotationView == nil) {
                var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Custom");
                annotationView.animatesDrop = true
                annotationView.draggable = true
            } else {
                annotationView.annotation = annotation;
                annotationView.draggable = true
            }
            
            //self.addBounceAnimationToView(annotationView)
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