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

    func addUser(name: String, key: String) {
    
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").setValue(["name": name, "key": key])
    }
    
    func addDog(name: String, key: String) {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child("My Dog").setValue(["name": name, "key": key])
    }
    
    func addLikedDog(name: String, key: String) {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child("My Liked Dog").setValue(["name": name, "key": key])
    }
    
    /*the following method is for temporary explaination of retrieving data,
     may be moved to controller for implemenation*/
    func viewDog(name: String, key: String) {
        
        //Attach a listener to receive updates
        ref.observe(.value, with: { snapshot in
            var newDogs: [Dog] = []
            for item in snapshot.children {
                let dog = Dog(snapshot: item as! FIRDataSnapshot)
                newDogs.append(dog)
            }
            /* the following implementation may be applied to viewController */
            self.dogs = newDogs // this updates the field 'dogs' under the user referenced
            //self.view.reloadData()
        })
    
    }
    /* the following method is intended to be implemented in some tableViewController,
       which is to delete a dog in cell */
    func tableView(_tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let dogToBeDeleted = dog[indexPath.row]
            dogToBeDeleted.ref?.removeValue()
        }
    }
}
