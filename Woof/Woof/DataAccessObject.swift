//
//  DataAccessObject.swift
//  Woof
//
//  Created by Ciel Slytherin on 2017/2/12.
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
    
    func addLikedDog(name: String, key: String) {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("User Profile").child("My Liked Dog").setValue(["name": name, "key": key])
    }
}
