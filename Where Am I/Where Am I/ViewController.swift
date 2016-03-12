//
//  ViewController.swift
//  Where Am I
//
//  Created by Kevin Amiranoff on 12/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
  
  var manager:CLLocationManager!
  
  @IBOutlet var latitudeLabel: UILabel!
  @IBOutlet var longitudeLabel: UILabel!
  @IBOutlet var courseLabel: UILabel!
  @IBOutlet var speedLabel: UILabel!
  @IBOutlet var altitudeLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //basic set up for an app using geolocalization
    manager = CLLocationManager()
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
    //basic set up for an app using geolocalization
    
    

  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print(locations)
    let userLocation:CLLocation = locations[0]
    self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
    self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
    
    self.courseLabel.text = "\(userLocation.course)"
    self.speedLabel.text = "\(userLocation.speed)"
    self.altitudeLabel.text = "\(userLocation.altitude)"
    
    CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks,error) -> Void in
      if(error != nil){
        print(error)
      }else{
        print(placemarks);
        if let p:CLPlacemark? = CLPlacemark(placemark: placemarks![0] ) {
          self.addressLabel.text = "\(p?.postalCode) \(p?.country) \(p?.subAdministrativeArea) \(p?.subLocality) \(p?.thoroughfare) \(p?.subThoroughfare)"
        }
      }
    
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

