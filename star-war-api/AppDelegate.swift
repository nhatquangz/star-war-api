//
//  AppDelegate.swift
//  star-war-api
//
//  Created by nhatquangz on 07/01/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		window = UIWindow(frame: UIScreen.main.bounds)
		let navigationViewController = UINavigationController()
		self.window?.rootViewController = navigationViewController
		self.window?.makeKeyAndVisible()
		navigationViewController.viewControllers = [HomeViewController()]
		MockedNetwork()
		return true
	}
}

