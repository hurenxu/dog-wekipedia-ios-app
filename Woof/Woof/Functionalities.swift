//
//  Functionalities.swift
//  Woof
//
//  Created by Joanna Xu on 2/16/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Functionalities{
    
    var databaseHandle: FIRDatabaseHandle?
    
    static var breedList = [Breed]()
    
    var currBreed: Breed?
    
    var dogIDList = [String]()
    
    static var myUser: User?
    
    static var userExist = false
    
    init(){}
    // return a whole dog breed list for woofipedia
    // call this method in viewdidload
    func retrieveBreedList(controller: SearchTableViewController) {
        let ref = FIRDatabase.database().reference()
        databaseHandle = ref.child("Breeds").observe(.value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                print("-")
                
                //print(next.key)
                var breed = next.value as? NSDictionary
                //var breed = snapshot.value as? NSDictionary
                
                //print(breed)
                
                //if let actualbreed = breed {
                let thisbreed = Breed(dictionary: breed!)
                print(thisbreed.getBreedName())
                Functionalities.breedList.append(thisbreed)
                //}
                
                controller.dogs.append(thisbreed)
                controller.tableView.reloadData()
            }
            
        })
        //        let dao = DataAccessObject()
        //        currBreed = dao.viewBreed(breedName: "Yorkshire")
        //        breedList.append(currBreed!)
    }
    

    
    func retrieveDogList(controller: iPetViewController) {
        let ref = FIRDatabase.database().reference()
        //Functionalities.myUser = controller.user
        databaseHandle = ref.child("Dog Profile").observe(.value, with: {(snapshot) in
            let dogs = snapshot.value as? NSDictionary
            let keys = dogs?.allKeys as? [NSString]
            
            for key in keys! {
                for id in (Functionalities.myUser?.dogIDs)! {
                    if (id == key as String) {
                        print("found")
                        let dog = dogs?[key] as? NSDictionary
                        let thisDog = Dog(dictionary: dog!)
                        var toCheck = 0
                        for index in controller.dogID {
                            if (index == key as String) {
                                toCheck = 1
                            }
                        }
                        if (toCheck != 1) {
                            thisDog.dogID = key as String
                            controller.ownedDog.append(thisDog.name)
                            controller.age.append(thisDog.age)
                            controller.breed.append(thisDog.breed.breedName)
                            controller.gender.append(thisDog.gender)
                            controller.color.append(thisDog.color)
                            controller.dogID.append(key as String)
                            controller.dogList.append(thisDog)
                            
                            controller.collectView.reloadData()
                        }
                        toCheck = 0
                    }
                }
            }
            
//            let enumerator = snapshot.children
//            while let next = enumerator.nextObject() as? FIRDataSnapshot {
//                var dog = next.value as? NSDictionary
//                let currentDogID = dog?["dogID"] as? String
//                for id in (Functionalities.myUser?.dogIDs)! {
//                    var nowID = id
//                    if (currentDogID == nowID) {
//                        let thisDog = Dog(dictionary: dog!)
//                        controller.ownedDog.append(thisDog.name)
//                        controller.dogList.append(thisDog)
//                        controller.age.append(thisDog.age)
//                        controller.breed.append(thisDog.breed.breedName)
//                        controller.gender.append(thisDog.gender)
//                        controller.color.append(thisDog.color)
//                        controller.collectView.reloadData()
//                        print("REACH &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
//                    }
//                }
            
                
                
            //}
            
        })
    }
    
    func userExist(user:User) -> Bool {
        let ref = FIRDatabase.database().reference()
        ref.child("User Profile").observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot.value as? NSDictionary
            let keys = users?.allKeys as! [NSString]
            for key in keys {
                if (Functionalities.myUser?.userID == key as String) {
                    Functionalities.userExist = true
                    print("((((((((((((((((((((((((((((((((((((((((((((")
                    print(Functionalities.userExist)
                    self.retrieveUserProfile(user: Functionalities.myUser!)
                }
            }
        })
        
        return false
        
    }
    
    func retrieveUserProfile(user:User) -> User {
        let ref = FIRDatabase.database().reference()
        ref.child("User Profile").child(user.userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let profile = snapshot.value as? NSDictionary
            let thisuser = User(dictionary: profile!)
            Functionalities.myUser = thisuser
            Functionalities.myUser?.userID = user.userID
        })
        
        return Functionalities.myUser!
    }
    
//    func retrieveProfileForDogList(controller: iPetViewController) {
//        let ref = FIRDatabase.database().reference()
//        let myUserID = Functionalities.myUser?.userID
//        databaseHandle = ref.child("User Profile").observe(.value, with: { (snapshot) in
//            let enumerator = snapshot.children
//            while let next = enumerator.nextObject() as? FIRDataSnapshot {
//                var currentUser = next.value as? NSDictionary
//                let currentUserID = currentUser?["userID"] as? String
//                if (currentUserID == myUserID) {
//                    let currentUserWanted = User(dictionary: currentUser!)
//                    
//                    //TODO: need to replace the following with correct dog object
//                    //controller.dogIDList = currentUserWanted.dogIDs
//                    //like this:
//                    Functionalities.myUser = currentUserWanted
//                    
//                    print("REACH THIS LINE ************************************************************************************************************************************************************************************************************")
//                    self.retrieveDogList(controller: controller)
//                }
//            }
//            
//        })
//    }
    
    func getBreedList(controller: SearchTableViewController) -> [Breed] {
        retrieveBreedList(controller: controller)
        print(Functionalities.breedList)
        return Functionalities.breedList
    }
    
    func setUser(user: User) {
        Functionalities.myUser = user
    }
    
    func getUser() -> User {
        return Functionalities.myUser!
    }
    
    
}

