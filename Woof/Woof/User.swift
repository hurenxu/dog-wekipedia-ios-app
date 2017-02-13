import Foundation
import Firebase

struct User{
    
	let uid: String
	let name: String
	let email: String
    var dogs: [Dog] = []

	init(authData:FIRUser) {
		uid = authData.uid
		name = authData.displayName!
		email = authData.email!
        
        if (!self.userExist()) {
            self.addUserEntry()
        }
	}
	
    func addUserEntry() {
        DataAccessObject.addUser(self)
    }
    
    func userExist() -> Bool {
        return false
    }
}
