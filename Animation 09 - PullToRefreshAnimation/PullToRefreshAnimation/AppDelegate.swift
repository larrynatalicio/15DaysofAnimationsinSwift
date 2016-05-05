//
//  AppDelegate.swift
//  PullToRefreshAnimation
//
//  Created by Larry Natalicio on 4/25/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        configureStatusBar()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) { }
    func applicationDidEnterBackground(application: UIApplication) { }
    func applicationWillEnterForeground(application: UIApplication) { }
    func applicationDidBecomeActive(application: UIApplication) { }
    func applicationWillTerminate(application: UIApplication) { }
}

extension AppDelegate {
    func configureStatusBar() {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
}

