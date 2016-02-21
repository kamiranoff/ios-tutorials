//
//  ViewController.swift
//  Hello World
//
//  Created by Kevin Amiranoff on 20/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        log("this is a log")
    }
    
    
    
    
    
    @IBAction func submit(sender: AnyObject) {
        log("Button tapped")
    
        var elvisAge = textField.text;
        if(elvisAge! == ""){
            elvisAge = "??"
        }
        
        label.text = "Elvis was born on " + elvisAge!;
        if(textField.text! == "1943"){
            answerLabel.text = "Well done";
            
        }else{
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


}

