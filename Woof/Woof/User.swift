import Foundation
import Firebase

class User{
    
    // immutable uid
    var userID: String
    //var firstName: String
    //var lastName: String
    var name: String?
    var email: String?
    var age = 0
    var gender: String?
    var favoriteDogBreeds: [String] = []
    var favoriteCategoryFilters: [String] = []
    var zipCode = ""
    var image = ""
    var dogIDs: [String] = []
    
    
    init(authData:FIRUser) {
        userID = authData.uid
        name = authData.displayName!
        email = authData.email!
        gender = "F"
        
//        if (!self.userExist()) {
//            self.addUserProfileEntry()
//        }
        print(self.userExist())
    }
    
    init(dictionary: NSDictionary) {
        
        userID = (dictionary["userID"] as? String) ?? ""
        
        let keys = dictionary.allKeys
        for key in keys {
            if (key as? String == "name") {
                name = (dictionary["name"] as? String)!
            }
            if (key as? String == "email") {
                email = (dictionary["email"] as? String)!
            }
            if (key as? String == "age") {
                age = (dictionary["age"] as? Int)!
            }
            if (key as? String == "gender") {
                gender = (dictionary["gender"] as? String)!
            }
            if (key as? String == "favoriteDogBreeds") {
                let favoriteDogBreedsDic = (dictionary["favoriteDogBreeds"] as? NSArray)!
                for breed in favoriteDogBreedsDic {
                    favoriteDogBreeds.append(breed as! String)
                }
            }
            if (key as? String == "favoriteCategoryFilters") {
                let favoriteCategoryFiltersDic = (dictionary["favoriteCategoryFilters"] as? NSArray)!
                for breed in favoriteCategoryFiltersDic {
                    favoriteCategoryFilters.append(breed as! String)
                }
            }
            if (key as? String == "dogIDs") {
                dogIDs = (dictionary["dogIDs"] as? [String])!
            }
            if (key as? String == "zipCode") {
                zipCode = (dictionary["zipCode"] as? String)!
            }
            if (key as? String == "image") {
                image = (dictionary["image"] as? String)!
            }
        }
    }
    
    
    func addUserProfileEntry() {
        let dao = DataAccessObject()
        dao.addUser(user: self)
    }
    
    func addDog(dog: Dog) {
        dogIDs.append(dog.getDogID())
        dog.addDogProfileEntry()
        
        let dao = DataAccessObject()
        dao.updateUser(user: self)
    }
    func breedIsLiked(breedname: String) -> Bool {
        return self.favoriteDogBreeds.contains(breedname)
    }
    
    func addFavoriteDogBreed(breedname: String) {
        if (self.favoriteDogBreeds.contains(breedname)) {
            
        } else {
            self.favoriteDogBreeds.append(breedname)
        }
    }
    func removeFavoriteDogBreed(breedname: String) {
        self.favoriteDogBreeds = self.favoriteDogBreeds.filter{$0 != breedname}
    }
    
    
    func addFavoriteCategoryFilter(filter: String) {
        self.favoriteCategoryFilters.append(filter)
    }
    
    func removeFavoriteCategoryFilter(filter: String) {
        self.favoriteCategoryFilters = self.favoriteCategoryFilters.filter{$0 != filter}
    }
    func updateUser() {
        let dao = DataAccessObject()
        dao.updateUser(user: self)
    }
    func updateDog(dog: Dog) {
        let dao = DataAccessObject()
        dao.updateDog(dog: dog)
    }
    func deleteDog(dog: Dog) {
        
        for (index, element) in self.dogIDs.enumerated() {
            if (element == dog.getDogID()) {
                self.dogIDs.remove(at: index)
            }
        }
        let dao = DataAccessObject()
        dog.deleteDogProfileEntry()
        dao.updateUser(user: self)
        
    }
    func viewUser(user: User) -> Any {
        let dao = DataAccessObject()
        return dao.viewUser(user: self)
    }
    
    
    func userExist() -> Bool {
        let tools = Functionalities()
        return tools.userExist(user:self)
        //return false

    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return self.name!
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func getEmail() -> String {
        return self.email!
    }
    
    func setAge(age: Int) {
        self.age = age
    }
    
    func getAge() -> Int {
        return self.age
    }
    
    func setGender(gender: String) {
        self.gender = gender
    }
    
    func getGender() -> String {
        return self.gender!
    }
    
    func setZipCode(code: String) {
        self.zipCode = code
    }
    
    func getZipCode() -> String {
        return self.zipCode
    }
    
    func setImage(imageURL: String) {
        self.image = imageURL
    }
    
    func getImage() -> String {
        return self.image
    }
}
