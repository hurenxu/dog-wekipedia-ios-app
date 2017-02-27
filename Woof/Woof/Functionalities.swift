//
//  Functionalities.swift
//  Woof
//
//  Created by Joanna Xu on 2/16/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Functionalities {
    
    var databaseHandle: FIRDatabaseHandle?
    
    var breedList = [Breed]()
    
    var currBreed: Breed?
    
    init(){}
    // return a whole dog breed list for woofipedia
    // call this method in viewdidload
    func retrieveBreedList() {
        let ref = FIRDatabase.database().reference()
        databaseHandle = ref.child("Breeds").child("Yorkshire").observe(.value, with: { (snapshot) in
            let breed = snapshot.value as? NSDictionary
            
            print(breed)
            
            //if let actualbreed = breed {
                let thisbreed = Breed(dictionary: breed!)
                print(thisbreed)
                self.breedList.append(thisbreed)
            //}
        })
//        let dao = DataAccessObject()
//        currBreed = dao.viewBreed(breedName: "Yorkshire")
//        breedList.append(currBreed!)
    }
    
    func getBreedList() -> [Breed] {
        retrieveBreedList()
        print(breedList)
        return self.breedList
    }
}

