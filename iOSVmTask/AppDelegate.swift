//
//  AppDelegate.swift
//  iOSVmTask
//
//  Created by Taresh Jain on 01/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Variable
        var window: UIWindow?

        // MARK: Application life cycle
        // Getting Line Length Violation warning, so added line length disable rule only for below method
        // swiftlint:disable line_length
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // swiftlint:enable line_length
            // Override point for customization after application launch.
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = Helper.initializeRootViewController(viewController: PeopleViewController())
            window?.makeKeyAndVisible()
            return true
        }
}

