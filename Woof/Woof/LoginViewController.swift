//
//  LoginViewController.swift
//  Woof
//
//  Created by Joanna Xu on 1/31/17.
//  Copyright © 2017 Woof. All rights reserved.
//
import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    
    var count: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // let image = UIImage(named:"bacgroundHome.png")
        let shade = UIImageView(frame:UIScreen.main.bounds)
        shade.backgroundColor = UIColor.black
        shade.alpha = 0.5
        self.view.addSubview(shade)
        self.view.sendSubview(toBack: shade)
        
        
        let BackimageView = UIImageView(frame:UIScreen.main.bounds)
        BackimageView.image = UIImage(named:"bacgroundHome.png")
        self.view.addSubview(BackimageView)
        self.view.sendSubview(toBack: BackimageView)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        //GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func browse(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindtoWelcomeView(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func facebookLogin(sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) {(result, error)in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                if user != nil {
                    Functionalities.myUser = User(authData:(user)!)
                    //Functionalities.userExist = true
                    //                    let dogID = (Functionalities.myUser?.userID)! + (Functionalities.myUser?.dogIDs.count.description)!
                    //                    let age = "3"
                    //                    let birthdate = NSDate.distantPast
                    //                    let vaccinedate = NSDate.distantFuture
                    
                    
                    //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
                    
                    //                    let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
                    //
                    //                    let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
                    //                    Functionalities.myUser?.addDog(dog: myDog)
                    //
                    //
                    //                    let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
                    //user.updateDog(dog: updateMyNewDog)
                    //user.deleteDog(dog: updateMyNewDog)
                }
                // Present the main view
                //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                //    UIApplication.shared.keyWindow?.rootViewController = viewController
                //    self.dismiss(animated: true, completion: nil)
                //}
                
            })
            /*
             if FIRAuth.auth()?.currentUser != nil {
             let user = User(authData: (FIRAuth.auth()?.currentUser)!)
             
             Functionalities.myUser = user
             Functionalities.userExist = true
             //user.addUserProfileEntry()
             //let controller:iPetViewController = (iPetViewController(coder: NSCoder))!
             //controller.user = user
             
             
             //test for IPetViewController
             //let tools = Functionalities()
             //tools.setUser(user:self.user!)
             //test finish
             
             //let tools = Functionalities()
             //print(tools.getBreedList())
             
             let dogID = user.userID + user.dogIDs.count.description
             let age = "3"
             let birthdate = NSDate.distantPast
             let vaccinedate = NSDate.distantFuture
             
             
             //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
             
             //let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
             
             //let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
             //user.addDog(dog: myDog)
             
             
             //let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
             //user.updateDog(dog: updateMyNewDog)
             //user.deleteDog(dog: updateMyNewDog)
             
             
             } else {
             // No user is signed in.
             // ...
             }
             */
            self.performSegue(withIdentifier: "login", sender: self)
        }
        
        
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            // TODO
            print("GIDSIGNIN!!!!! ERROR")
            return
        }
        
        // google_credential
        guard let authentication = user.authentication else { return }
        print("NO ERROR!!!!!!")
        
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        let rootViewController = self
        // [START_EXCLUDE]
        // Perform login by calling Firebase APIs
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                rootViewController.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            print("FIREBASE CURRENT USER ??????")
            if FIRAuth.auth()?.currentUser != nil {
                print("FIREBASE CURRENT USER NOT NIL@@@@@@@@")
                let user = User(authData: (FIRAuth.auth()?.currentUser)!)
                
                Functionalities.myUser = user
                //Functionalities.userExist = true
                
                //                let dogID = user.userID + user.dogIDs.count.description
                //                let age = "3"
                //                let birthdate = NSDate.distantPast
                //                let vaccinedate = NSDate.distantFuture
                
                
                //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
                
                //                let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
                //
                //                let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
                //                user.addDog(dog: myDog)
                //
                //
                //                let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
                
            }
            self.performSegue(withIdentifier: "login", sender: self)
            
            // Present the main view
            //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            //    UIApplication.shared.keyWindow?.rootViewController = viewController
            //    self.dismiss(animated: true, completion: nil)
            //}
            
        })/*
         print("FIREBASE CURRENT USER ??????")
         if FIRAuth.auth()?.currentUser != nil {
         print("FIREBASE CURRENT USER NOT NIL@@@@@@@@")
         let user = User(authData: (FIRAuth.auth()?.currentUser)!)
         
         Functionalities.myUser = user
         Functionalities.userExist = true
         
         let dogID = user.userID + user.dogIDs.count.description
         let age = "3"
         let birthdate = NSDate.distantPast
         let vaccinedate = NSDate.distantFuture
         
         
         //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
         
         let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
         
         let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
         user.addDog(dog: myDog)
         
         
         let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
         
         }*/
        
        
        
        
        print("google Login there???")/*
         let myStBd = UIStoryboard(name: "Main",bundle:nil)
         logCon.performSegue(withIdentifier: "login", sender: self)*/
        
        
        self.performSegue(withIdentifier: "login", sender: self)
        
        
        
        //viewController.performSegue(withIdentifier: "login", sender: viewController)
        // Then push that view controller onto the navigation stack
        
        //rootViewController?.navigationController?.pushViewController(viewController, animated: true);
        //rootViewController?.navigationController?.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        
        print("HOPE PERFORM SEGUE HERE")
        //rootViewController?.childViewControllers.performSegue(withIdentifier: login, sender: LoginViewController)
        // [END_EXCLUDE]
        
    }
    
    @IBAction func googleLogin(sender: GIDSignInButton) {
        
        
        //GIDSignIn.sharedInstance().signIn()
        let signIn = GIDSignIn.sharedInstance()
        signIn?.scopes = ["https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/plus.me"]
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            
            GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/userinfo.email")
            GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/userinfo.profile")
            GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
            print("HAS KEY!!!!!!!!!")
            let usr = GIDSignIn.sharedInstance().currentUser
            if usr != nil {
                print("User has been successfully signed in with Google")
                GIDSignIn.sharedInstance().signInSilently()
            }
            else{
                print("USER NILL!!!!!!")
                GIDSignIn.sharedInstance().signIn()
                
            }
            
        } else {
            GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
            print("User has failed in signing in with Google")
            GIDSignIn.sharedInstance().signIn()
            
        }
        
        
        //let user = GIDSignIn.sharedInstance().currentUser
        
        //print(user)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //print(appDelegate.gidauth)
        guard let authentication = appDelegate.gidauth else {
            print("USER!!!!!")
            return
        }
        
        print(authentication)
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        print(credential)
        // [START_EXCLUDE]
        // Perform login by calling Firebase APIs
        /*
         FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
         
         if let error = error {
         print("Login error: \(error.localizedDescription)")
         let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
         let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(okayAction)
         self.present(alertController, animated: true, completion: nil)
         
         return
         }
         if user != nil {
         Functionalities.myUser = User(authData:(user)!)
         Functionalities.userExist = true
         let dogID = (Functionalities.myUser?.userID)! + (Functionalities.myUser?.dogIDs.count.description)!
         let age = "3"
         let birthdate = NSDate.distantPast
         let vaccinedate = NSDate.distantFuture
         
         
         
         print("****************************************************************************************")
         //user.addUserProfileEntry()
         //let controller:iPetViewController = (iPetViewController(coder: NSCoder))!
         //controller.user = user
         
         
         //test for IPetViewController
         //let tools = Functionalities()
         //tools.setUser(user:self.user!)
         //test finish
         
         //let tools = Functionalities()
         //print(tools.getBreedList())
         
         
         
         
         
         
         print("Functionalities!!!!!!!!!!!!!!!!", Functionalities.myUser)
         //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
         
         let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
         
         let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
         Functionalities.myUser?.addDog(dog: myDog)
         
         
         let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
         //user.updateDog(dog: updateMyNewDog)
         //user.deleteDog(dog: updateMyNewDog)
         }
         // Present the main view
         //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
         //    UIApplication.shared.keyWindow?.rootViewController = viewController
         //    self.dismiss(animated: true, completion: nil)
         //}
         self.performSegue(withIdentifier: "login", sender: self)
         
         })*/
        print("googleLogin here")
        /*
         if FIRAuth.auth()?.currentUser != nil {
         let user = User(authData: (FIRAuth.auth()?.currentUser)!)
         
         Functionalities.myUser = user
         print("****************************************************************************************")
         //user.addUserProfileEntry()
         //let controller:iPetViewController = (iPetViewController(coder: NSCoder))!
         //controller.user = user
         
         
         //test for IPetViewController
         //let tools = Functionalities()
         //tools.setUser(user:self.user!)
         //test finish
         
         //let tools = Functionalities()
         //print(tools.getBreedList())
         
         let dogID = user.userID + user.dogIDs.count.description
         let age = "3"
         let birthdate = NSDate.distantPast
         let vaccinedate = NSDate.distantFuture
         
         print("Functionalities!!!!!!!!!!!!!!!!", Functionalities.myUser)
         //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
         
         let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
         
         let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
         user.addDog(dog: myDog)
         
         
         let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
         //user.updateDog(dog: updateMyNewDog)
         //user.deleteDog(dog: updateMyNewDog)
         
         
         } else {
         // No user is signed in.
         // ...
         
         }*/
        
        //print("google Login there")
        //self.performSegue(withIdentifier: "login", sender: self)
        
    }
    /*
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
     if error != nil {
     // TODO
     print("TTTTTTTTTTTTTTTT")
     return
     }
     print("HAHAHAHAHAHAHAHAH")
     // google_credential
     guard let authentication = user.authentication else { return }
     let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
     accessToken: authentication.accessToken)
     // [START_EXCLUDE]
     // Perform login by calling Firebase APIs
     FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
     if let error = error {
     print("Login error: \(error.localizedDescription)")
     let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
     let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alertController.addAction(okayAction)
     self.present(alertController, animated: true, completion: nil)
     
     return
     }
     
     // Present the main view
     //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
     //    UIApplication.shared.keyWindow?.rootViewController = viewController
     //    self.dismiss(animated: true, completion: nil)
     //}
     
     })
     
     
     // [END_EXCLUDE]
     }*/
    
    /*
     @IBAction func googleLogin(sender: UIButton) {
     GIDSignIn.sharedInstance().signIn()
     print("googleLogin here")
     if FIRAuth.auth()?.currentUser != nil {
     let user = User(authData: (FIRAuth.auth()?.currentUser)!)
     
     Functionalities.myUser = user
     print("****************************************************************************************")
     //user.addUserProfileEntry()
     //let controller:iPetViewController = (iPetViewController(coder: NSCoder))!
     //controller.user = user
     
     
     //test for IPetViewController
     //let tools = Functionalities()
     //tools.setUser(user:self.user!)
     //test finish
     
     //let tools = Functionalities()
     //print(tools.getBreedList())
     
     let dogID = user.userID + user.dogIDs.count.description
     let age = "3"
     let birthdate = NSDate.distantPast
     let vaccinedate = NSDate.distantFuture
     
     
     //let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
     
     let myDogBreed = Breed(breedName: "Yorkshire Terrier", popularity: "Highest", origin: "England", group: "Small", size: "small", type: "type", lifeExpectancy: "20", colors: "white", litterSize: "20", price: "1000", barkingLevel: "okay", childFriendly: "yes", breeders: "none", image: "image")
     
     let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
     user.addDog(dog: myDog)
     
     
     let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
     //user.updateDog(dog: updateMyNewDog)
     //user.deleteDog(dog: updateMyNewDog)
     
     
     } else {
     // No user is signed in.
     // ...
     }
     
     //print("google Login there")
     self.performSegue(withIdentifier: "login", sender: self)
     }
     
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
     if error != nil {
     // TODO
     return
     }
     // google_credential
     guard let authentication = user.authentication else { return }
     let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
     accessToken: authentication.accessToken)
     // [START_EXCLUDE]
     // Perform login by calling Firebase APIs
     FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
     if let error = error {
     print("Login error: \(error.localizedDescription)")
     let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
     let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alertController.addAction(okayAction)
     self.present(alertController, animated: true, completion: nil)
     
     return
     }
     
     // Present the main view
     //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
     //    UIApplication.shared.keyWindow?.rootViewController = viewController
     //    self.dismiss(animated: true, completion: nil)
     //}
     
     })
     
     // [END_EXCLUDE]
     }
     */
    
}
