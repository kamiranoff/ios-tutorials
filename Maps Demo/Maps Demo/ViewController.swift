//
//  ViewController.swift
//  Maps Demo
//
//  Created by Kevin Amiranoff on 09/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

  @IBOutlet var map: MKMapView!
  
  var locationManager = CLLocationManager()
  
  func drawMap(region:MKCoordinateRegion,annotation:MKPointAnnotation,longPress:UILongPressGestureRecognizer){
    map.setRegion(region, animated: true)
    map.addAnnotation(annotation);
    map.addGestureRecognizer(longPress);
  }
  
  
  func getLocation(latitude:CLLocationDegrees,longitude:CLLocationDegrees) -> CLLocationCoordinate2D{
    let latitude:CLLocationDegrees = latitude
    let longitude:CLLocationDegrees = longitude
    
    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    return location;
  }
  
  
  func createRegion() -> MKCoordinateRegion{
    let location = getLocation(37.779276,longitude: -122.419232)
    //difference of latitude of one size of the screen to the other
    //1 is zoommed in.
    //the closest to 0 is zoomedOut
    let latDelta:CLLocationDegrees = 0.1
    let longDelta:CLLocationDegrees = 0.1
    let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta);
    
    let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    return region;
  }
  
  func createAnnotation() -> MKPointAnnotation{
    let location = getLocation(37.779276,longitude: -122.419232);
    let annotation = MKPointAnnotation()
    annotation.coordinate = location;
    annotation.title = "San Francisco";
    annotation.subtitle = "California dreamin'"
    return annotation
  }
  
  
  func createLongPress() -> UILongPressGestureRecognizer{

    //the colon at the end sets the UIGestureRecognizer adn allow to pass information with action
    let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "action:")
    longPressRecognizer.minimumPressDuration = 2;
    return longPressRecognizer
  }
  
  func action(gestureRecognizer:UIGestureRecognizer){
    print("gesture recognized")
    
    let touchPoint = gestureRecognizer.locationInView(self.map);
    let newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
 
    let annotation = MKPointAnnotation()
    annotation.coordinate = newCoordinate;
    annotation.title = "User Place";
    annotation.subtitle = "California dreamin'"
    map.addAnnotation(annotation);
  
  }
  
  
//Uncomment to get userLocation
//  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    print(locations)
//    
//    let userLocation: CLLocation = locations[0]
//    let latitude = userLocation.coordinate.latitude
//    let longitude = userLocation.coordinate.longitude
//    let location = getLocation(latitude, longitude: longitude)
//    let latDelta:CLLocationDegrees = 0.05
//    let longDelta:CLLocationDegrees = 0.05
//    let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta);
//    
//    let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//    self.map.setRegion(region, animated: false)
//  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    let region = createRegion();
    let annotation = createAnnotation()
    let longPress = createLongPress()
    drawMap(region,annotation: annotation,longPress: longPress)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

