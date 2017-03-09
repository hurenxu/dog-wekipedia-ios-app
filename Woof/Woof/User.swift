import Foundation
import Firebase

class User{
    
    // immutable uid
    let userID: String
    //var firstName: String
    //var lastName: String
    var name: String
    var email: String
    var age = 0
    var gender: String
    var favoriteDogBreeds: [String] = ["Yorkshire", "Chihuahua"]
    var favoriteCategoryFilters: [String] = ["Black", "Small"]
    var zipCode = ""
    var image = ""
    var dogIDs: [String] = []
    
    
    init(authData:FIRUser) {
        userID = authData.uid
        name = authData.displayName!
        email = authData.email!
        gender = "F"
        
        if (!self.userExist()) {
            self.addUserProfileEntry()
        }
        //self.userExist()
    }
    
    init(dictionary: NSDictionary) {
        
        userID = (dictionary["userID"] as? String) ?? ""
        name = (dictionary["name"] as? String)!
        email = (dictionary["email"] as? String)!
        age = (dictionary["age"] as? Int)!
        gender = (dictionary["gender"] as? String)!
        let favoriteDogBreedsDic = (dictionary["favoriteDogBreeds"] as? NSArray)!
        let favoriteCategoryFiltersDic = (dictionary["favoriteCategoryFilters"] as? NSArray)!
        zipCode = (dictionary["zipCode"] as? String)!
        image = (dictionary["image"] as? String)!
        dogIDs = (dictionary["dogIDs"] as? [String])!
        
        for breed in favoriteDogBreedsDic {
            favoriteDogBreeds.append(breed as! String)
        }
        for breed in favoriteCategoryFiltersDic {
            favoriteCategoryFilters.append(breed as! String)
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
    
    func addFavoriteDogBreed(breedname: String) {
        self.favoriteDogBreeds.append(breedname)
    }
    
    func addFavoriteCategoryFilter(filter: String) {
        self.favoriteCategoryFilters.append(filter)
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
//        let tools = Functionalities()
//        return tools.userExist(user:self)
        return false

    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func getEmail() -> String {
        return self.email
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
        return self.gender
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
