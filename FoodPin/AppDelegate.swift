//
//  AppDelegate.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarControllers: [UIViewController] = []
    var baseTabBarController: UITabBarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        baseTabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarControllers.append(favoritesViewController())
        tabBarControllers.append(discoverViewController())
        tabBarControllers.append(aboutViewController())
        
        baseTabBarController.setViewControllers(tabBarControllers, animated: false)

        configureTabBarItems()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = baseTabBarController
        window?.makeKeyAndVisible()
        
        let backButtonImage = UIImage(named: "back")
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        
        UITabBar.appearance().tintColor = .orange
        UITabBar.appearance().barTintColor = .black
        
        return true
    }
    
    func favoritesViewController() -> UIViewController {
        let rootViewController = YQRestaurantTableViewController()
        return UINavigationController(rootViewController: rootViewController)
    }
    
    func discoverViewController() -> UIViewController {
        let rootViewController = UIViewController()
        return UINavigationController(rootViewController: rootViewController)
    }
    
    func aboutViewController() -> UIViewController {
        let rootViewController = UIViewController()
        return UINavigationController(rootViewController: rootViewController)
    }
    
    func configureTabBarItems() {
        let tabBarItems = baseTabBarController.tabBar.items
        let itemsCount: Int = tabBarItems?.count ?? 0
        if itemsCount > 0 {
            for index in 0...itemsCount - 1 {
                var title = ""
                var image = ""
                switch index {
                case 0:
                    title = "Favorites"
                    image = "favorite"
                case 1:
                    title = "Discover"
                    image = "discover"
                case 2:
                    title = "About"
                    image = "about"
                default:
                    return
                }
                
                if let tabBarItem = tabBarItems?[index] {
                    tabBarItem.title = title
                    tabBarItem.image = UIImage(named: image)
                }
            }
        }

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodPin")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

