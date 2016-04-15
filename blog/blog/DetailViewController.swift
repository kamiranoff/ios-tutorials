//
//  DetailViewController.swift
//  blog
//
//  Created by Kevin Amiranoff on 15/04/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//





import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!

  @IBOutlet var bioOutlet: UITextView!
  @IBOutlet var imageOutlet: UIImageView!
  
  var detailItem: AnyObject? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView() {
    // Update the user interface for the detail item.
    print(activeImage)
    if let checkedUrl = NSURL(string: activeImage) {
      imageOutlet.contentMode = .ScaleAspectFill
      downloadImage(checkedUrl)
    }
    bioOutlet.text = activeItem
    
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
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
        self.imageOutlet.image = UIImage(data: data)
      }
    }
  }
  
}


