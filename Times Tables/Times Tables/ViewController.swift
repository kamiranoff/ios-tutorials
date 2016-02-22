//
//  ViewController.swift
//  Times Tables
//
//  Created by Kevin Amiranoff on 22/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

  
  @IBOutlet var slider: UISlider!
  @IBOutlet var table: UITableView!
  
  @IBAction func sliderMoved(sender: AnyObject) {
    
    print(slider);
    table.reloadData();
  }
 

  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 20;
  }
  

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
    let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"Cell");
    
    
    let timesTable = Int(slider.value * 20);
  
    cell.textLabel?.text = String(timesTable * (indexPath.row + 1));
    
    
    return cell
    
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

