//
//  ViewController.swift
//  Animations
//
//  Created by Kevin Amiranoff on 07/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var count = 2;
  var timer = NSTimer()
  var isAnimated = true;

  @IBOutlet var imageContainer: UIImageView!
  
   
  @IBAction func btn(sender: AnyObject) {
    if(isAnimated){
      timer.invalidate()
      isAnimated = false
    }else{
      startTimer()
      isAnimated = true
    }

    
  }
  
  func startTimer(){
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    startTimer()
    
  }


  
  func doAnimation(){
    let image = "psylocke\(count).png";
    imageContainer.image = UIImage(named:image);
    if(count < 9){
      count++
    }else{
      count = 1;
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  //on subview layout
  override func viewDidLayoutSubviews() {
    
    //slide from left
    imageContainer.center = CGPointMake(imageContainer.center.x - 400, imageContainer.center.y)
    
    //opacity
    //imageContainer.alpha = 0
    
    //scale animation
    //imageContainer.frame = CGRectMake(0, 28, 0, 0);
  }
  
  //on view appeared
  override func viewDidAppear(animated: Bool) {
    UIView.animateWithDuration(1 , animations: { () -> Void in
      //slide from left
      self.imageContainer.center = CGPointMake(self.imageContainer.center.x + 400, self.imageContainer.center.y)
      
      //opacity
      //self.imageContainer.alpha = 1
      
      //scale animation
      //self.imageContainer.frame = CGRectMake(0, 28, 375,561);
    })
  }
}

