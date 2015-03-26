//
//  SecondViewController.swift
//  KittenFriends
//
//  Created by Mark Pleskac on 2/23/15.
//  Copyright (c) 2015 Mark Pleskac. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var historyMap: MKMapView!
    var locationManager:CLLocationManager!
    let dataHelper = SightingHelper(fromAppDelegate: (UIApplication.sharedApplication().delegate as AppDelegate));
    
    // This is NOT performant. This is SO BAD.
    func hardRefreshSightings(){
        // Remove ALL annotations
        let annotationsToRemove = historyMap.annotations
        historyMap.removeAnnotations( annotationsToRemove )
        
        // Add back ALL annotations
        addPinsToMap()
    }
    
    override func viewDidAppear(animated: Bool) {
        hardRefreshSightings();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        historyMap.delegate = self;
        setUserLocation();
        
        //addPinsToMap()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.historyMap.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    
    func setUserLocation(){
        if(locationManager == nil){
            locationManager = CLLocationManager();
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
        }
        
        // Get current location
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func addPinsToMap(){
        var sightings = dataHelper.getSightings();
        
        // TODO: only add necessary pins, or limit it? IDK.
        for s in sightings{
            var sightingAnnotation = MKPointAnnotation()
            var lat = CLLocationDegrees(s.lat);
            var long = CLLocationDegrees(s.long);
            sightingAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            sightingAnnotation.title = s.color
            historyMap.addAnnotation(sightingAnnotation)
        }
    }
}

