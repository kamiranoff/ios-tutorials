//
//  ViewController.swift
//  Memorables Places
//
//  Created by Kevin Amiranoff on 12/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

  var manager:CLLocationManager!
  
  @IBOutlet var map: MKMapView!
  
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    manager = CLLocationManager()
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest
    
    if(TableViewController.myPlaces.activePlace == -1){
      manager.requestWhenInUseAuthorization()
      manager.startUpdatingLocation()
    }else{
 
        
        let latitude = NSString(string:TableViewController.myPlaces.places[TableViewController.myPlaces.activePlace]["lat"]!).doubleValue
        let longitude = NSString(string:TableViewController.myPlaces.places[TableViewController.myPlaces.activePlace]["lon"]!).doubleValue
      
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
      
      let latDelta:CLLocationDegrees = 0.01
      let lonDelta:CLLocationDegrees = 0.01
      
      let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
      let region = MKCoordinateRegionMake(coordinate, span )
      self.map.setRegion(region, animated: true)
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      annotation.title = TableViewController.myPlaces.places[TableViewController.myPlaces.activePlace]["name"]
      self.map.addAnnotation(annotation);
     

      
    }
    
    
    let uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
    
    uilpgr.minimumPressDuration = 2.0
    map.addGestureRecognizer(uilpgr)
  }
  
  func action(gestureRecognizer:UIGestureRecognizer){
    if(gestureRecognizer.state == UIGestureRecognizerState.Began){
      let touchPoint = gestureRecognizer.locationInView(self.map)
      let newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
      
      let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
      
      CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        
        var annotationTitle = "";
        
        if(error == nil){
          if let p:CLPlacemark? = CLPlacemark(placemark: placemarks![0] ) {
            var subThoroughfare = ""
            var thoroughfare = ""
            
            if(p!.subThoroughfare != nil){
              subThoroughfare = p!.subThoroughfare!
            }
            
            if(p!.thoroughfare != nil){
              thoroughfare = p!.thoroughfare!
            }
            
            annotationTitle = "\(subThoroughfare) \(thoroughfare)"
          }
          
        }
     
        
      
      if(annotationTitle == ""){
          annotationTitle = "Added \(NSDate())"
      }
  
      TableViewController.myPlaces.places.append(["name":annotationTitle,"lat":"\(newCoordinate.latitude)","lon":"\(newCoordinate.longitude)"])
      print("places",TableViewController.myPlaces.places);
      
      NSUserDefaults.standardUserDefaults().setObject(TableViewController.myPlaces.places, forKey: "myPlaces");
       
      let annotation = MKPointAnnotation()
      annotation.coordinate = newCoordinate
      annotation.title = annotationTitle
      self.map.addAnnotation(annotation);
      })
    }
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation:CLLocation = locations[0] 
    let latitude = userLocation.coordinate.latitude
    let longitude = userLocation.coordinate.longitude
    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    
    let latDelta:CLLocationDegrees = 0.01
    let lonDelta:CLLocationDegrees = 0.01
    
    let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
    let region = MKCoordinateRegionMake(coordinate, span )
    self.map.setRegion(region, animated: true)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

