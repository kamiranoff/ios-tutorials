//
//  ViewController.swift
//  Table Views
//
//  Created by Kevin Amiranoff on 22/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

  
  var cellContent = ["Psylocke","Wolverine","Shadowcat","Jean Grey","Cyclops"];
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return cellContent.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell");
   
    cell.textLabel?.text = cellContent[indexPath.row];
    
    return cell
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

