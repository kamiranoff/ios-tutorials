//
//  ViewController.swift
//  weather app
//
//  Created by Kevin Amiranoff on 29/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import XCGLogger

class ViewController: UIViewController {
  
  @IBOutlet var textField: UITextField!
  @IBOutlet var resultLabel: UILabel!
  
  @IBAction func findWeather(sender: AnyObject) {
    
    var wasSuccessful = false
    
    let updatedTextFieldText =  textField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-");
    
    log.verbose(updatedTextFieldText);
    
    let attemptedUrl = NSURL(string:  "http://www.weather-forecast.com/locations/" + updatedTextFieldText + "/forecasts/latest")
    
    if let url = attemptedUrl{
      
      log.verbose("Attempting")
      
      let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
        
        if let urlContent = data {
          
          let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
          let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">");
          
          if(websiteArray.count > 1){
            
            let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
            
            if weatherArray.count > 1 {
              log.verbose("Was Successful");
              wasSuccessful = true;
              
              let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
              
              dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.resultLabel.text = weatherSummary
              })
              
            }
            
          }
       
        }
        if(wasSuccessful == false){
          dispatch_async(dispatch_get_main_queue(), { () -> Void in

            self.resultLabel.text = "Could not find the weather for what you typed in."
          })
        }
      }
      
      
      task.resume();
    }else{
      log.verbose("UNSUCCESSFUL")
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        self.resultLabel.text = "Could not find the weather for what you typed in."
      })

    }
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

