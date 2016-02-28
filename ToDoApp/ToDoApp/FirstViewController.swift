//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by Kevin Amiranoff on 27/02/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit



var toDoList = [String]();

class FirstViewController: UIViewController,UITableViewDelegate {
  
  

  @IBOutlet var todoListTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if(NSUserDefaults.standardUserDefaults().objectForKey("toDoList") != nil){
      toDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoList") as! [String]
    }
    
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return toDoList.count
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let cell = UITableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:"Cell" )
    cell.textLabel?.text = toDoList[indexPath.row];
    return cell;
  }
  
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
    if(editingStyle == UITableViewCellEditingStyle.Delete){
      toDoList.removeAtIndex(indexPath.row);
      
      NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList");
      
      todoListTable.reloadData()
    }
  }

  override func viewDidAppear(animated: Bool) {
    todoListTable.reloadData();
  }
}

