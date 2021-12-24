//
//  AppDelegate.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 9.12.2021.
//

import UIKit
import PaylinkSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var mainWindow = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PaylinkSDK.configure(clientID: "910162c0-a0e6-40b8-b66d-f6a9d56bee0f",
                             clientSecret: "c7667cce1d82212b39090e697e6cf1a300453d8af730ccce0878307b9fb43034")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainVC")
        let nc = UINavigationController(rootViewController: vc)
        mainWindow.rootViewController = nc
        mainWindow.makeKeyAndVisible()
        
        return true
    }
}