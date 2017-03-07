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
                self.breedList.append(thisbreed)
            //}
            
                controller.dogs.append(thisbreed)
                controller.tableView.reloadData()
            }
            
        })
//        let dao = DataAccessObject()
//        currBreed = dao.viewBreed(breedName: "Yorkshire")
//        breedList.append(currBreed!)
    }
    
    func getBreedList(controller: SearchTableViewController) -> [Breed] {
        retrieveBreedList(controller: controller)
        print(breedList)
        return self.breedList
    }
}

