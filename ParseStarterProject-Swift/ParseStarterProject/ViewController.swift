/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
  
  
  var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBAction func signup(sender: AnyObject) {
  
    if (username.text == "" || password.text == ""){
      displayAlert("Error in form", message: "Please enter a username or password")
    }else{
      
      activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
      activityIndicator.center = self.view.center;
      activityIndicator.hidesWhenStopped = true;
      activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
      view.addSubview(activityIndicator)
      activityIndicator.startAnimating()
      UIApplication.sharedApplication().beginIgnoringInteractionEvents()
      
      
      
      var errorMessage = "Please try again later"
      let user = PFUser()
      user.username = username.text
      user.password = password.text
      
      user.signUpInBackgroundWithBlock { (success, error) in
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        if error == nil {
          //signup successful
        }else{
          if let errorString = error?.userInfo["error"] as? String{
            errorMessage = errorString
          }
          
          self.displayAlert("Failed to sign up", message: errorMessage)
          
        }
      }

    }
  }
  
  @IBAction func login(sender: AnyObject) {
    
    
  }
  
  
  func displayAlert(title:String,message:String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction((UIAlertAction(title: "ok", style: .Default, handler: { (action) in
      self.dismissViewControllerAnimated(true, completion: nil)
    })))
    
    self.presentViewController(alert, animated: true, completion: nil)
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
