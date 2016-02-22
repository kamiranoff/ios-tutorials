//
//  ViewController.swift
//  Hello World
//
//  Created by Kevin Amiranoff on 20/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField.delegate = self;
        log("this is a log")
    }
    
    
    
    
    
    @IBAction func submit(sender: AnyObject) {
        log("Button tapped")
    
        var elvisAge = textField.text;
        if(elvisAge! == ""){
            elvisAge = "??"
        }
      
        if(textField.text! == "1943"){
            answerLabel.text = "Well done";
          label.text = "Elvis was born on " + elvisAge!;
          label.backgroundColor = UIColor.blueColor();
            
        }else{
          label.text = "Completely wrong";
          
            answerLabel.text = "Try again";
        }
    }
    
    
    
    func log(message:String){
        print(message)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(textField:UITextField!) -> Bool{
    textField.resignFirstResponder()
    
    return true;
  }

}

