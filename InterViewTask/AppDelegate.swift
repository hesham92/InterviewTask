//
//  AppDelegate.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 9/28/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        
        InternetConnection.shared.setObservers()
        AppNavigator.shared.start(window: &window)
        
        return true
    }
}

