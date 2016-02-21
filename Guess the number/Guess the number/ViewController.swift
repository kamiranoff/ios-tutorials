//
//  ViewController.swift
//  Guess the number
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
    
    
    @IBOutlet var inputNumber: UITextField!
    @IBOutlet var numberBox: UILabel!


    @IBAction func tryYourLuckButton(sender: AnyObject) {
        let randomInt:Int = Int(arc4random_uniform(5) + 1);
        
        print("randomInt",randomInt);
        print("inputNumber",inputNumber.text);
        
        let inputInt = Int(inputNumber.text!);
        
        if(randomInt == inputInt){
            numberBox.text = "RIGHT GUESS"
        }else{
            numberBox.text = "Try again";
        }
        
    }
}

