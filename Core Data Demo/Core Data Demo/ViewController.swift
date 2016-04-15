//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Kevin Amiranoff on 13/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //defaut delegate for AppDelegate
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    
    //handler that allows us to access CoreData
    let context: NSManagedObjectContext = appDelegate.managedObjectContext
    
    
    //Create a user
//    let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
//    newUser.setValue("Betsy Baddrock", forKey: "username")
//    newUser.setValue("admin", forKey: "password")
//    newUser.setValue("Psylocke", forKey: "surname")
//    do{
//      try  context.save();
//    }catch{
//      print("Could not save user to db");
//    }
    
    //fetch results from db
    let request = NSFetchRequest(entityName: "Users")
    
    
    //let us access data and its values
    request.returnsObjectsAsFaults = false;
    
    //allow to search the db for a particular value
    request.predicate = NSPredicate(format: "username = %@", "Betsy Baddrock")
    
    //execute request
    do{
      let results = try context.executeFetchRequest(request)
      if(results.count > 0){
//        for result in results as! [NSManagedObject]{
//          print(result.valueForKey("username")!);
//        }
//        for result:AnyObject in results{
//          
//          if let pass = result.password!{
//            print(pass)
//          }
//        }
        for result:AnyObject in results{
          if let username:String = result.valueForKey("username") as? String{
            print(username);
            result.setValue("psylocke",forKey:"username")
            
            context.deleteObject(result as! NSManagedObject)
            try context.save()
          }
        }
      }else{
        print("no result");
      }
      
    }catch{
      print("Could not fetch from db")
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

