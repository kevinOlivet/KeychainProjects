//
//  AppDelegate.swift
//  KeychainTouchMeIn
//
//  Created by Jon Olivet on 11/9/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let navigationController = window!.rootViewController as! UINavigationController
    let controller = navigationController.topViewController as! MasterViewController
    controller.managedObjectContext = self.managedObjectContext
    prepareNavigationBarAppearance()
    
    return true
  }
  
  func prepareNavigationBarAppearance() {
    let barColor = UIColor(red: 43.0/255.0, green: 43.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    UINavigationBar.appearance().barTintColor = barColor
    UINavigationBar.appearance().tintColor = UIColor.white

    let font = UIFont(name: "Avenir-Black", size: 30)!
    let regularVertical = UITraitCollection(verticalSizeClass: .regular)
    let titleDict: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font]
    
    UINavigationBar.appearance(for: regularVertical).titleTextAttributes = titleDict
    
    UIToolbar.appearance().barTintColor = barColor
    UIToolbar.appearance().tintColor = UIColor.white
  }
  
  
  func applicationWillResignActive(_ application: UIApplication) {
    UIApplication.shared.ignoreSnapshotOnNextApplicationLaunch()
  }
  
  
  func applicationWillTerminate(_ application: UIApplication) {
    saveContext()
  }
  
  // MARK: - Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
    
    let persistentContainer = NSPersistentContainer(name: "KeychainTouchMeIn")
    persistentContainer.loadPersistentStores { (storeDescription, error) in
      if let error = error {
        print(error)
      } else {
        print("Core Data initiated")
      }
    }
    return persistentContainer
  }()
  
  var managedObjectContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Core Data Saving support
  func saveContext() {
    guard managedObjectContext.hasChanges else {
      return
    }
  
    do {
      try managedObjectContext.save()
    } catch {
      print(error)
    }
  }
}
