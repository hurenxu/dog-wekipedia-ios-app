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

    func addDogProfileEntry() {
        let dao = DataAccessObject()
        let dog = Dog(name: "aaa")
        dao.addDog(dog: dog)
    }
    
    func userExist() -> Bool {
        return false
    }
    
    
}
