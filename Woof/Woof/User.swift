import Foundation
import Firebase

class User{
    
    // immutable uid
	let userID: String
    //var firstName: String
    //var lastName: String
    var name: String
    var email: String
    var dogs: [Dog] = []
    


	init(authData:FIRUser) {
		userID = authData.uid
		name = authData.displayName!
		email = authData.email!
        
        if (!self.userExist()) {
            self.addUserEntry()
        }
	}
	
    func addUserEntry() {
        let dao: DataAccessObject
        
    }
    
    func concatenateName() {
        
    }
    
    func userExist() -> Bool {
        return false
    }
}
