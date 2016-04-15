//
//  MasterViewController.swift
//  blog
//
//  Created by Kevin Amiranoff on 15/04/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import CoreData


var activeItem = "";
var activeImage = "";

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

  var detailViewController: DetailViewController? = nil
  var managedObjectContext: NSManagedObjectContext? = nil

  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let context:NSManagedObjectContext = appDel.managedObjectContext;
    
    
    let urlPath = NSURL(string:"http://192.168.0.35:3000/marvelapi/characters/")
    
    // Asynchronous Http call to your api url, using NSURLSession:
    NSURLSession.sharedSession().dataTaskWithURL( urlPath!, completionHandler: { (data, response, error) -> Void in
      // Check if data was received successfully
      if error == nil && data != nil {
        do {
          
          
          var request = NSFetchRequest(entityName: "Heroes")
          request.returnsObjectsAsFaults = false;
          
          do{
            let results = try context.executeFetchRequest(request)
            for result in results{
              context.deleteObject(result as! NSManagedObject)
              do{
                try context.save()
                
              }catch{
                print("errors while saving in core data")
              }
              
            }
          }catch{
            print("errors while requesting from core data")
          }
          
          // Convert NSData to Dictionary where keys are of type String, and values are of any type
          let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray         // Access specific key with value of type String
      
          
          var newHeroItem:NSManagedObject
          
          
          for item in json {
            
            let characterDictionary = item["character"] as! NSDictionary
            
            let name = characterDictionary["name"] as! String
            var bio = "";
            if( (characterDictionary["wiki"]) != nil ){
              bio = characterDictionary["wiki"]!["bio"] as! String
            }
            let characterImgPath = characterDictionary["thumbnail"]!["path"] as! String;
            let characterImgExt = characterDictionary["thumbnail"]!["extension"] as! String;
           
           
            newHeroItem = NSEntityDescription.insertNewObjectForEntityForName("Heroes", inManagedObjectContext: context)
            
            newHeroItem.setValue(name, forKey: "name")
            newHeroItem.setValue(bio, forKey: "bio")
            newHeroItem.setValue(characterImgPath, forKey: "imgPath")
            newHeroItem.setValue(characterImgExt, forKey: "imgExt")
            
            do{
              try context.save()
              
            }catch{
              print("errors while saving in core data")
              print(ErrorType)
            }
          
          }
          
     
          
          request = NSFetchRequest(entityName: "Heroes")
          request.returnsObjectsAsFaults = false;
          
          do{
            let results = try context.executeFetchRequest(request)
            
          }catch{
            print("errors while requesting from core data")
            print(ErrorType)
          }


        } catch {
          // Something went wrong
        }
      }
    }).resume()
    
  
    
    if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  


  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func insertNewObject(sender: AnyObject) {
    let context = self.fetchedResultsController.managedObjectContext
    let entity = self.fetchedResultsController.fetchRequest.entity!
    let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
         
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    newManagedObject.setValue(NSDate(), forKey: "timeStamp")
         
    // Save the context.
    do {
        try context.save()
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //print("Unresolved error \(error), \(error.userInfo)")
        abort()
    }
  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
          
          let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
          activeItem = object.valueForKey("bio")!.description
          let path = object.valueForKey("imgPath")?.description;
          let ext = object.valueForKey("imgExt")?.description;
          activeImage = path! + "." + ext!;
          

          
             let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
         
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.fetchedResultsController.sections?.count ?? 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionInfo = self.fetchedResultsController.sections![section]
    return sectionInfo.numberOfObjects
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
    self.configureCell(cell, withObject: object)
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
        let context = self.fetchedResultsController.managedObjectContext
        context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
  }

  func configureCell(cell: UITableViewCell, withObject object: NSManagedObject) {
    cell.textLabel!.text = object.valueForKey("name")!.description
   // cell.detailTextLabel?.text = object.valueForKey("bio")!.description
  }

  // MARK: - Fetched results controller

  var fetchedResultsController: NSFetchedResultsController {
      if _fetchedResultsController != nil {
          return _fetchedResultsController!
      }
      
      let fetchRequest = NSFetchRequest()
      // Edit the entity name as appropriate.
      let entity = NSEntityDescription.entityForName("Heroes", inManagedObjectContext: self.managedObjectContext!)
      fetchRequest.entity = entity
      
      // Set the batch size to a suitable number.
      fetchRequest.fetchBatchSize = 20
      
      // Edit the sort key as appropriate.
      let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
      
      fetchRequest.sortDescriptors = [sortDescriptor]
      
      // Edit the section name key path and cache name if appropriate.
      // nil for section name key path means "no sections".
      let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
      aFetchedResultsController.delegate = self
      _fetchedResultsController = aFetchedResultsController
      
      do {
          try _fetchedResultsController!.performFetch()
      } catch {
           // Replace this implementation with code to handle the error appropriately.
           // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
           //print("Unresolved error \(error), \(error.userInfo)")
           abort()
      }
      
      return _fetchedResultsController!
  }    
  var _fetchedResultsController: NSFetchedResultsController? = nil

  func controllerWillChangeContent(controller: NSFetchedResultsController) {
      self.tableView.beginUpdates()
  }

  func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
      switch type {
          case .Insert:
              self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
          case .Delete:
              self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
          default:
              return
      }
  }

  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
      switch type {
          case .Insert:
              tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
          case .Delete:
              tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
          case .Update:
              self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, withObject: anObject as! NSManagedObject)
          case .Move:
              tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
      }
  }

  func controllerDidChangeContent(controller: NSFetchedResultsController) {
      self.tableView.endUpdates()
  }

  /*
   // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
   
   func controllerDidChangeContent(controller: NSFetchedResultsController) {
       // In the simplest, most efficient, case, reload the table view.
       self.tableView.reloadData()
   }
   */

}

