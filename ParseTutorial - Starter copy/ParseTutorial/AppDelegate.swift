//
//  AppDelegate.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/6/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("JbwyUiNHMAHEsSBSStMmI45BIIgz4FCdTRGIuEQd", clientKey: "34xwDvP0LYMrZ1vtfL4vu8mbddwx14ArecOq29a1")
        
//   //1 - below we are creating the query object, thename will be the name of the tbale where you want to look
//        let query = PFQuery(className: "Player")
//   //2 - you are limiting the objects you will get to scores above 1000
//        query.whereKey("Name", equalTo: "John")
//        query.whereKey("Score", greaterThan: 1000)
//   //3 - send the query and print the result closure
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil {
//                print("Successfully retreieved: \(objects)")
//            } else {
//                print("Error: \(error) \(error?.userInfo)")
//            }
//        }
  // here we are using asynchronous mode to upload the object and checking the result in a closure
  // PFObject is a bse class that provides basic object manipulation methods.
  // *** THis code is only for an example and is unnecessary for the app. If this code remains, you will add the same instance of the player object each time the app is ran.
//        let player = PFObject(className: "Player")
//        player.setObject("John", forKey: "Name")
//        player.setObject(1230, forKey: "Score")
//        player.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//            if succeeded {
//                print("Object Uploaded")
//            } else {
//                print("Error: \(error) \(error?.userInfo)")
//            }
//        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

