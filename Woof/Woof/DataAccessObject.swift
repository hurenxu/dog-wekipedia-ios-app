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
}
