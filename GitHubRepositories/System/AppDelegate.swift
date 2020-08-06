//
//  AppDelegate.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.start()
    return true
  }

  // MARK: UISceneSession Lifecycle
  
  func start() {
    let constructor = Constructor()
    let initialCoordinator = constructor.makeInitialCoordinator()
    
    let rootNC = NavigationViewController()
    
    initialCoordinator.start(rootNC)
    
    self.window?.rootViewController = rootNC
    self.window?.makeKeyAndVisible()
  }

}

