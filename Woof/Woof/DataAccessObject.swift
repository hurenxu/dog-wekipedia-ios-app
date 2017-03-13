//
//  DataAccessObject.swift
//  Woof
//
//  Created by Ciel Slytherin on 2017/2/12.
//  Modified by Siya Li on 2017/02/16
//  Copyright © 2017年 Woof. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataAccessObject {
    
    var databaseHandle: FIRDatabaseHandle?
    
    init(){}
    
    var currBreed: Breed?

    func addUser(user: User) {
    
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child(user.userID).setValue(["name": user.name, "email": user.email, "age":user.age, "gender":user.gender, "favoriteDogBreeds":user.favoriteDogBreeds, "favoriteCategoryFilters":user.favoriteCategoryFilters, "zipCode":user.zipCode, "image":user.image, "dogIDs":user.dogIDs])
    }
    
    func addDog(dog: Dog) {
        
        let ref = FIRDatabase.database().reference()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        
        ref.child("Dog Profile").child(dog.dogID).setValue(["name": dog.name, "breed": dog.breed.breedName, "age": dog.age, "gender": dog.gender, "birthDate": dateFormatter.string(from: dog.birthDate), "description": dog.description, "vaccination": dateFormatter.string(from:dog.vaccination), "color": dog.color, "image": dog.image])
    }
    
    func viewUser(user: User) -> Any{
        let ref = FIRDatabase.database().reference()
        return ref.child("User Profile").child(user.userID)
        
    }
    
    func viewDog(dog: Dog) -> Any{
        let ref = FIRDatabase.database().reference()
        return ref.child("Dog Profile").child(dog.dogID)
        
    }
    
    func updateUser(user: User) {
        let ref = FIRDatabase.database().reference()
        ref.child("User Profile").child(user.userID).setValue(["name": user.name, "email": user.email, "age": user.age, "gender": user.gender, "favoriteDogBreeds": user.favoriteDogBreeds, "favoriteCategoryFilters": user.favoriteCategoryFilters, "zipCode": user.zipCode, "image": user.image, "dogIDs": user.dogIDs])

    }
    
    func updateDog(dog: Dog){
        let ref = FIRDatabase.database().reference()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        ref.child("Dog Profile").child(dog.dogID).setValue(["name": dog.name, "breed": dog.breed.breedName, "age": dog.age, "gender": dog.gender, "birthDate": dateFormatter.string(from: dog.birthDate), "vaccination": dateFormatter.string(from:dog.vaccination),  "color": dog.color, "description": dog.description, "image": dog.image])
    }
    
    func deleteUser(user: User) {
        
    }
    
    func deleteDog(dog: Dog) {
        let ref = FIRDatabase.database().reference()
        

        ref.child("Dog Profile").child(dog.dogID).removeValue(completionBlock:{(error, ref) in
            if error != nil {
                print("error \(error)")
            }
        })
        
    }
    
    func addLikedDog(name: String, key: String) {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child("My Liked Dog").setValue(["name": name, "key": key])
    }
    
    
//    func viewBreed(breed: Breed)-> Breed {
//        let ref = FIRDatabase.database().reference()
//        databaseHandle = ref.child("Breeds").child(breed.breedName).observe(.value, with: { (snapshot) in
//
//            let value = snapshot.value as? NSDictionary
//            breed.setPersonality(personality: (value?["personality"] as? String)!)
//            print(breed.getPersonality())
//            
//        }) { (error) in
//            
//            print(error.localizedDescription)
//        }
//        print(breed.getPersonality())
//        return breed
//
//    }
    
    func viewBreed(breedName: String) -> Breed {
        let ref = FIRDatabase.database().reference()
        databaseHandle = ref.child("Breeds").child(breedName).observe(.value, with: { (snapshot) in
            let breed = snapshot.value as? NSDictionary
            
            
            let currBreed = Breed(dictionary: breed!)
            print(currBreed)
            
        })
        
        return currBreed!
    }

    /*the following method is for temporary explaination of retrieving data,
     may be moved to controller for implemenation*/
    func updateDogList(dogs: [Dog]) {
        
        let ref = FIRDatabase.database().reference()
        //Attach a listener to receive updates
        ref.observe(.value, with: { snapshot in
            var newDogs: [Dog] = []
            for item in snapshot.children {
                //let dog = Dog(snapshot: item as! FIRDataSnapshot)
                //newDogs.append(dog)
            }
            /* the following implementation may be applied to viewController */
            //dogs = newDogs // this updates the field 'dogs' under the user referenced
            //self.view.reloadData()
        })
    
    }
    /* the following method is intended to be implemented in some tableViewController,
       which is to delete a dog in cell */
//    func tableView(_tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            let dogToBeDeleted = dog[indexPath.row]
//            dogToBeDeleted.ref?.removeValue()
//        }
//    }
    

}
