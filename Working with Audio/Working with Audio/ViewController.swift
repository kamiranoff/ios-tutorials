//
//  ViewController.swift
//  Working with Audio
//
//  Created by Kevin Amiranoff on 12/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  
  
  var player:AVAudioPlayer = AVAudioPlayer()
  
  @IBOutlet var slider: UISlider!
  
  
  
  @IBAction func playBtn(sender: AnyObject) {
   player.play()
  }
  
  @IBAction func pauseBtn(sender: AnyObject) {
    player.pause()
    
  }
  
  @IBAction func sliderAction(sender: AnyObject) {
    
      player.volume = slider.value;
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let audioPath = NSBundle.mainBundle().pathForResource("Always-on-my-mind", ofType: "mp3")!
    
    
    do{
      try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
      
      
    }catch{
      //error handling
      print("could not launch the player")
    }

    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

