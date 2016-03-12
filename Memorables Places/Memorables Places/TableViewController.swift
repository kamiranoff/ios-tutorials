//
//  TableViewController.swift
//  Memorables Places
//
//  Created by Kevin Amiranoff on 12/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit





class TableViewController: UITableViewController {
  
  
  struct myPlaces {
    static var places = [Dictionary<String,String>()]
    static var activePlace = -1
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("places",myPlaces.places);
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to displ ay an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
    
    if(NSUserDefaults.standardUserDefaults().objectForKey("myPlaces") != nil){
      myPlaces.places = NSUserDefaults.standardUserDefaults().objectForKey("myPlaces") as! [Dictionary]
    }
    
    if(myPlaces.places.count == 1){
      
      myPlaces.places.removeAtIndex(0);
      
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    
    print("places.count",myPlaces.places)
    return myPlaces.places.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    cell.textLabel?.text = myPlaces.places[indexPath.row]["name"]
    return cell
  }
  
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    myPlaces.activePlace = indexPath.row
    return indexPath
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "newPlace"){
      myPlaces.activePlace = -1;
    }
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
    if(editingStyle == UITableViewCellEditingStyle.Delete){
      myPlaces.places.removeAtIndex(indexPath.row);
      
      NSUserDefaults.standardUserDefaults().setObject(myPlaces.places, forKey: "myPlaces");
      
      tableView.reloadData()
    }
  }
  
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the specified item to be editable.
  return true
  }
  */
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the item to be re-orderable.
  return true
  }
  */
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
