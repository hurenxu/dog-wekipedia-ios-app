//
//  AppDelegate.swift
//  Woof
//
//  Created by Joanna Xu on 1/31/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate{

    var window: UIWindow?

    var gidauth: GIDAuthentication!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //change nav bar appearance
        var navigationBarAppearance = UINavigationBar.appearance()
//        navigationBarAppearance.tintColor = UIColor(netHex: 0xa5c3bb)
        navigationBarAppearance.tintColor = UIColor(netHex: 0x000000)
        navigationBarAppearance.barTintColor = UIColor(netHex: 0xa5c3bb)
        var searchBarAppearance = UISearchBar.appearance()
        searchBarAppearance.barTintColor = UIColor(netHex: 0xa5c3bb)
        searchBarAppearance.tintColor = UIColor.black
        
        // change navigation item title color
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(netHex: 0x000000)]
        navigationBarAppearance.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Rubik", size: 19)!]
        
        FIRApp.configure()
        let facebook = FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return facebook
    }
    /*
    func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        
        
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL!,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)
        
        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        print("googleDidHandle!!!!!!!!!!!!!!!!",googleDidHandle)
        
        return googleDidHandle || facebookDidHandle
    }*/
    

    func application(_ app: UIApplication, open url: URL, options:[UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
                                             sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                             annotation: [:])

        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        return googleDidHandle || facebookDidHandle
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Override point for customization after application launch.
//        
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
//        
//        GIDSignIn.sharedInstance().delegate = self
//        
//        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            // TODO
            print("GIDSIGNIN!!!!! ERROR")
            return
        }
        
        
        
        
        // google_credential
        guard let authentication = user.authentication else { return }
        print("NO ERROR!!!!!!")
        gidauth = authentication
        print(gidauth)
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        let rootViewController = self.window!.rootViewController
        // [START_EXCLUDE]
        // Perform login by calling Firebase APIs
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                rootViewController?.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            // Present the main view
            //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            //    UIApplication.shared.keyWindow?.rootViewController = viewController
            //    self.dismiss(animated: true, completion: nil)
            //}
            
        })
        
        if FIRAuth.auth()?.currentUser != nil {
            let user = User(authData: (FIRAuth.auth()?.currentUser)!)
            
            Functionalities.myUser = user
            
        }
        
        print("google Login there")/*
        let myStBd = UIStoryboard(name: "Main",bundle:nil)
        logCon.performSegue(withIdentifier: "login", sender: self)*/
        
        
        // Access the storyboard and fetch an instance of the view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        let viewController: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController;
        //viewController.performSegue(withIdentifier: "login", sender: viewController)
        // Then push that view controller onto the navigation stack
        
        //rootViewController?.navigationController?.pushViewController(viewController, animated: true);
        //rootViewController?.navigationController?.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        rootViewController?.navigationController?.performSegue(withIdentifier: "login", sender: viewController)
        print("HOPE PERFORM SEGUE HERE")
        //rootViewController?.childViewControllers.performSegue(withIdentifier: login, sender: LoginViewController)
        // [END_EXCLUDE]
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print(123)
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
/*
 * Enable to set color in hex
 */
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

