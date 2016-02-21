//
//  ViewController.swift
//  StopWatch
//
//  Created by Kevin Amiranoff on 21/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


  var time = 0;
  var timer = NSTimer();

  func startTimer(){
    time++;

    counter.text = String(time);
  }

  @IBOutlet var counter: UILabel!


  @IBAction func resetTimer(sender: AnyObject) {
    timer.invalidate();
    time = 0;
    counter.text = "0";


  }
  @IBAction func pauseTimer(sender: AnyObject) {
    timer.invalidate()
  }

  @IBAction func startTimer(sender: AnyObject) {

    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("startTimer"), userInfo: nil, repeats: true)

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

