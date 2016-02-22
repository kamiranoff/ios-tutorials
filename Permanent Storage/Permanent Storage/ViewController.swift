//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Kevin Amiranoff on 22/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults.standardUserDefaults().setObject("Kevin", forKey: "name");
  
    let username = NSUserDefaults.standardUserDefaults().objectForKey("name")! as! String;
    
    print(username);
    
    let arr = [1,2,3,4];
    
    NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
    
    let returnedArray = NSUserDefaults.standardUserDefaults().objectForKey("array")! as! NSArray
    

    for x in returnedArray{
      print(x);
    }
    
 
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

