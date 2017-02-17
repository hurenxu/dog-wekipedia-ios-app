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
    
    init(){}

    func addUser(user: User) {
    
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").setValue(["name": user.name, "key": user.userID])
    }
    
    func addDog(dog: Dog) {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child("My Dog").setValue(["name": dog.name, "key": dog.key])
    }
    
    func viewUser(user: User) {
        
    }
    
    func viewDog(dog: Dog) {
        
    }
    
    func updateUser(user: User) {
        
    }
    
    func updateDog(dog: Dog) {
        
    }
    
    func deleteUser(user: User) {
        
    }
    
    func deleteDog(dog: Dog) {
        
    }
    
    func addLikedDog(name: String, key: String) {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child("My Liked Dog").setValue(["name": name, "key": key])
    }
    
    /*the following method is for temporary explaination of retrieving data,
     may be moved to controller for implemenation*/
    func inspectDog(dogs: [Dog]) {
        
        let ref = FIRDatabase.database().reference()
        //Attach a listener to receive updates
        ref.observe(.value, with: { snapshot in
            var newDogs: [Dog] = []
            for item in snapshot.children {
                let dog = Dog(snapshot: item as! FIRDataSnapshot)
                newDogs.append(dog)
            }
            /* the following implementation may be applied to viewController */
            dogs = newDogs // this updates the field 'dogs' under the user referenced
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
