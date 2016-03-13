//
//  ViewController.swift
//  Swipes and Shakes
//
//  Created by Kevin Amiranoff on 13/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  
  
  var allFiles:Array<String> = []
  var mp3Files:Array<String> = []
  var wavFiles:Array<String> = []
  var player: AVAudioPlayer = AVAudioPlayer();
  let path = NSBundle.mainBundle().pathForResource("quotes", ofType: nil);
  var count = 0;
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    //SWIPE DETECTING CODE
    //    let swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
    //    swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
    //    self.view.addGestureRecognizer(swipeRight)
    //
    //    let swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
    //    swipeUp.direction = UISwipeGestureRecognizerDirection.Up;
    //    self.view.addGestureRecognizer(swipeUp)
    //
    //SWIPE DETECTING CODE
    
    
    
   
    do{
      allFiles = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(path!)
      
      for(var i = 0;i < allFiles.count;i++){
        let pathExtention = NSURL(fileURLWithPath: allFiles[i]).pathExtension
        let pathName = (allFiles[i] as NSString).stringByDeletingPathExtension
        if(pathExtention == "mp3"){
          mp3Files.append(pathName)
        }else if(pathExtention == "wav"){
          wavFiles.append(pathName)
        }
      }
 
      
    }catch{
      print("could not get files")
    }
    
    
    
    
    
    
//    while let element = enumerator.nextObject() as? String {
//      print(element);
//      if element.hasSuffix("mp3") { // checks the extension
//      }
//    }
    
   
  }
  //SWIPE DETECTING CODE
  //  func swiped(gesture:UIGestureRecognizer){
  //    if let swipeGesture = gesture as? UISwipeGestureRecognizer{
  //      switch swipeGesture.direction{
  //        case UISwipeGestureRecognizerDirection.Right:
  //          print("swiped right")
  //
  //        case UISwipeGestureRecognizerDirection.Up:
  //          print("swiped up");
  //
  //        default:
  //          break;
  //      }
  //    }
  //
  //  }
  //SWIPE DETECTING CODE
  
  
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if (event!.subtype == UIEventSubtype.MotionShake){
      print("Device was shaken")
      let randomNumber:Int;
      let fileLocation:String;
      if(count == 0){
         randomNumber = Int(arc4random_uniform(UInt32(mp3Files.count)))
         fileLocation = NSBundle.mainBundle().pathForResource(mp3Files[randomNumber],ofType: "mp3")!
        count++;
      }else{
         randomNumber = Int(arc4random_uniform(UInt32(wavFiles.count)))
         fileLocation = NSBundle.mainBundle().pathForResource(wavFiles[randomNumber],ofType: "wav")!
        count = 0;
      }
      print(fileLocation);
      do{
        try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLocation))
        player.play()
      }catch{
        print("Error while playing sound")
      }
    }
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

