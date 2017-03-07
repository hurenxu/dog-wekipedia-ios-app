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

class LoginViewController: UIViewController, GIDSignInUIDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
                
                // Present the main view
                //if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                //    UIApplication.shared.keyWindow?.rootViewController = viewController
                //    self.dismiss(animated: true, completion: nil)
                //}
                
            })
            
            if FIRAuth.auth()?.currentUser != nil {
                let user = User(authData: (FIRAuth.auth()?.currentUser)!)
                
                //let tools = Functionalities()
                //print(tools.getBreedList())
                
                let dogID = user.userID + String(user.dogIDs.count)
                let age = 3
                let birthdate = NSDate.distantPast
                let vaccinedate = NSDate.distantFuture
                
                
                let myDogBreed = Breed(breedName: "Yorkshire", image: "none", personality: "cute", origin:    "England", group: "Small", weight: "light", height: "short", head: "small", body: "small", ears: "small", hair: "blond", tail: "short", shedding: "no", grooming: "no", trainability: "easy", energyLevel: "high", barkingLevel: "low", lifeExpectancy: "long", description: "dorable", history: "long", breeders: "none")
                let myDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "non")
                //user.addDog(dog: myDog)
                
                let updateMyNewDog = Dog(dogID: dogID, name: "cutie", breed: myDogBreed, birthDate: birthdate, age: age, gender: "female", vaccination: vaccinedate, color: "Brown", description: "Mine", image: "this time I add in some description")
                //user.updateDog(dog: updateMyNewDog)
                //user.deleteDog(dog: updateMyNewDog)
                
                
            } else {
                    // No user is signed in.
                    // ...
            }
            
            self.performSegue(withIdentifier: "login", sender: self)
        }
        
    }
    
    @IBAction func googleLogin(sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
        print("googleLogin here")
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
        
        print("google Login there")
        self.performSegue(withIdentifier: "login", sender: self)

        // [END_EXCLUDE]
    }


}
