//
//  ViewController.swift
//  isPrime
//
//  Created by Kevin Amiranoff on 21/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  
  
  @IBOutlet var userInputField: UITextField!
  @IBOutlet var answerText: UILabel!
  
  @IBAction func calculateButton(sender: AnyObject) {
    if(userInputField.text == "" || userInputField.text == nil){
      answerText.text = "You must enter an integer";
    }else{
      
      let a:Int? = Int(userInputField.text!)     // firstText is UITextField
    
      if(isItPrime(a!)){
        answerText.text = "The number \(a!) is prime"
      }else{
        answerText.text = "The number \(a!) is not prime"
      }
    }
    
  }
  
  
  func isItPrime (number:Int) -> Bool{
    if(number == 2){
      return true
    }
    //check if n is a multiple of 2
    if(number % 2 == 0 || number == 1){
      return false;
    }
    //if not, then just check the odds
    for(var i = 3; i*i <= number; i+=2){
      if(number % i == 0){
        return false;
      }
    }
    return true;
  }
  
}

