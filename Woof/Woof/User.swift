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
    var gender = ""
    var favoriteDogBreeds: [String] = []
    var favoriteCategoryFilters: [String] = []
    var zipCode = 0
    var image = ""
    var dogIDs: [Int] = []
    

	init(authData:FIRUser) {
		userID = authData.uid
		name = authData.displayName!
		email = authData.email!
        gender = "F"
        
        if (!self.userExist()) {
            self.addUserProfileEntry()
        }
	}
	
    func addUserProfileEntry() {
        let dao = DataAccessObject()
        dao.addUser(user: self)
    }

    func addDog(dog: Dog) {
        dogIDs.append(dog.getDogID())
        dog.addDogProfileEntry()
    }
    
    func addFavoriteDogBreed(breedname: String) {
        self.favoriteDogBreeds.append(breedname)
    }
    
    func addFavoriteCategoryFilter(filter: String) {
        self.favoriteCategoryFilters.append(filter)
    }
    
    func userExist() -> Bool {
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
    
    func setZipCode(code: Int) {
        self.zipCode = code
    }
    
    func getZipCode() -> Int {
        return self.zipCode
    }
    
    func setImage(imageURL: String) {
        self.image = imageURL
    }
    
    func getImage() -> String {
        return self.image
    }
}
