//
//  AppDelegate.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/12/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            _ = try Realm()
        } catch {
            print("Error initializing ")
        }
        
        return true
    }
}

