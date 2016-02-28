//
//  ViewController.swift
//  Downloading web content
//
//  Created by Kevin Amiranoff on 28/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var webview: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    let url = NSURL(string: "http://www.stackoverflow.com")!;
    
    
    //load web view
    webview.loadRequest(NSURLRequest(URL:url));
    
    
    
    /*
    //loads web content
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
      //Will happen when task completes
      if let urlContent = data{
        let webcontent = NSString(data: urlContent,encoding:NSUTF8StringEncoding)
        
        //Show content when the content is downloaded
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
           self.webview.loadHTMLString(String(webcontent!), baseURL: nil)
          
        })
        
       
        
      }else{
        //show error message
      }
      
    }
    task.resume()
    */
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

