//
//  AppDelegate.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class textVC: UIViewController{
    
    let detailView = DetailView()
    override func viewDidLoad() {
        view.addSubview(detailView)
        view.backgroundColor = . green
        view.addSubview(textView)
    }
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.text = "630-673-1406"
        tv.sizeToFit() //expands frame to fit the text for PAL
        tv.frame.origin.y = 21 // bringing the y down 21 pixels.. for testing only!!
        tv.dataDetectorTypes = .phoneNumber
        //UIDataDetectorTypes.
        return tv
    }()
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        PersistantManager.manager.loadFavorites()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tbc = UITabBarController()
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let navController = UINavigationController(rootViewController: searchVC)
        let nvc = UINavigationController(rootViewController: favoritesVC)
        tbc.setViewControllers([navController, nvc], animated: true)
        window?.rootViewController = tbc
        window?.makeKeyAndVisible()
        return true
    
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


}

