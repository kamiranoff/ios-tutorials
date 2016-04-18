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
  

  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
  
  @IBAction func signup(sender: AnyObject) {
  
    if (username.text == "" || password.text == ""){
      let alert = UIAlertController(title: "Error in form", message: "Please enter username and password", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction((UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
        self.dismissViewControllerAnimated(true, completion: nil)
      })))
      
      self.presentViewController(alert, animated: true, completion: nil)
    }else{
      startActivity(activityIndicator);
    }
  }
  
  @IBAction func login(sender: AnyObject) {
    
    
  }
  
  func startActivity(act:UIActivityIndicatorView) -> UIActivityIndicatorView{
    let act = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
    act.center = self.view.center;
    act.hidesWhenStopped = true;
    act.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    view.addSubview(act)
    act.startAnimating()
    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    return act
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
