//
//  Dog.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class Dog: NSObject {
    // Mark: Variables
    let name: String?
    let imageURL: URL?
    let filters: String?
    let userLike: URL?
    //let breedersCount = NSNumber?
    
    // Mark: Initialize 
    
    // initialize variables
    init(dictionary: NSDictionary) {
        
        // initialize name to a string
        name = dictionary["name"] as? String
        
        // initialize imageURL to a URL
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        // initialize filters to a string
        let filtersArray = dictionary["filters"] as? [[String]]
        if filtersArray != nil {
            var filterNames = [String]()
            for filter in filtersArray! {
                let filterName = filter[0]
                filterNames.append(filterName)
            }
            filters = filterNames.joined(separator: ", ")
        } else {
            filters = nil
        }
        
        // initialize userLike to a URL
        let userLikeImageURLString = dictionary["user_like_img_url_large"] as? String
        if userLikeImageURLString != nil {
            userLike = URL(string: userLikeImageURLString!)
        } else {
            userLike = nil
        }
        
        //breedersCount = dictionary["breeders_count"] as? NSNumber
    }
    
    // Mark: Functions

    class func dogs(array: [NSDictionary]) -> [Dog] {
        var dogs = [Dog]()
        for dictionary in array {
            let dog = Dog(dictionary: dictionary)
            dogs.append(dog)
        }
        return dogs
    }
    
//    class func searchWithTerm(term: String, completion: @escaping ([Dog]?, Error?) -> Void) {
//        _ = API.dsfsdfd
//    }
    
}
