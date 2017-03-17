//
//  AppDelegate.swift
//  Sample
//
//  Created by Masuhara on 2017/03/14.
//  Copyright © 2017年 net.masuhara. All rights reserved.
//

import UIKit

// NCMBフレームワークの読み込み
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // NCMBとアプリと紐付ける
        NCMB.setApplicationKey("bcdc2cb33634dee3bf868646959a03c22af0fac98f3f7a4e2f8076e797490c4e", clientKey: "231c36d5d2f46aaca1cbe71f03e32dd54d88575ad900e5992c7907e1219915a4")
        
        // ログイン済かどうかUserDefaultsから読み込み
        let ud = UserDefaults.standard
        let isLogin = ud.bool(forKey: "isSignIn")
        
        if isLogin == false {
            // ログイン済でなかった場合、ログイン用のStoryboardを初期画面として起動
            let rootViewController: SignInViewController = UIStoryboard(name: "SignIn", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            let navigation = UINavigationController(rootViewController: rootViewController)
            self.window?.rootViewController = navigation
        }
        
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

