//
//  ViewController.swift
//  JSON Example
//
//  Created by Kevin Amiranoff on 20/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let url = NSURL(string: "http://localhost:3000/marvelapi/characters/56225d8a88f1d4bc16a86fa5")!
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
      if let urlContent = data{
        
        //serialize json
        do{
         let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
          
          print(jsonResult["character"]!!["name"])
        }catch{
          print("JSON serialization failed")
        }
        
      }
    }
    
    task.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

