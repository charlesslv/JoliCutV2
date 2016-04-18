//
//  FirstViewController.swift
//  Jolycut
//
//  Created by Vinod AROUMOUGAME on 13/04/16.
//  Copyright © 2016 Vinod AROUMOUGAME. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var MapView: MKMapView!

    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.MapView.mapType = MKMapType.Standard
        self.MapView.showsUserLocation = true
        
        self.MapView.removeAnnotations(self.MapView.annotations)
        
        
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let location = self.locationManager.location
        
        var latitude: Double = location!.coordinate.latitude
        let longitude: Double = location!.coordinate.longitude
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocations locations: [AnyObject])
    {
        //-
        
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        
        self.MapView.setRegion(region, animated: true)
        
        
        // Add an annotation on Map View
        let point: MKPointAnnotation! = MKPointAnnotation()
        
        point.coordinate = location.coordinate
        point.title = "Current Location"
        point.subtitle = "sub title"
        
        self.MapView.addAnnotation(point)
        
        //stop updating location to save battery life
        locationManager.stopUpdatingLocation()
        
    }
    
    
    //--- Uncomment to add custom annotation view ---//
    
     //--- use this code to add custom image (Annotation) for pin point ---//
     func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
     {
     if !(annotation is MKPointAnnotation)
     {
     return nil
     }
     
     let reuseId = "test"
     
     var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
     
     if anView == nil
     {
     anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
     anView!.image = UIImage(named:"1.png")
     anView!.canShowCallout = true
     }
     else
     {
     anView!.annotation = annotation
     }
     
     return anView
     }
}