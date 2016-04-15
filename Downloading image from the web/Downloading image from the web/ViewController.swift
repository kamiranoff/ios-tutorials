//
//  ViewController.swift
//  Downloading image from the web
//
//  Created by Kevin Amiranoff on 13/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var imageView: UIImageView!
 
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    print("Begin of code")
    let url = "http://www.kevinamiranoff.com/images/contact-bg2.jpg"
    if let checkedUrl = NSURL(string: url) {
      imageView.contentMode = .ScaleAspectFill
      downloadImage(checkedUrl)
      
    }
    print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
      completion(data: data, response: response, error: error)
      }.resume()
  }
  
  func downloadImage(url: NSURL){
    print("Download Started")
    print("lastPathComponent: " + (url.lastPathComponent ?? ""))
    getDataFromUrl(url) { (data, response, error)  in
      dispatch_async(dispatch_get_main_queue()) { () -> Void in
        guard let data = data where error == nil else { return }
        print(response?.suggestedFilename ?? "")
        print("Download Finished")
        self.imageView.image = UIImage(data: data)
        self.saveImage(data);
      }
    }
  }
  
  func saveImage(data:NSData){
    let documentsDirectory:String?
    let paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask , true)
    
    if (paths.count > 0){
      documentsDirectory = paths[0] as? String
      let savePath = documentsDirectory! + "/bg.jpg"
      print("savePath",savePath)
      NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
    }
  }


}

