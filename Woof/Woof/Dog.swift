import Foundation

class Dog{

	let name: String
    let breed: Breed

	init(name: String){
		self.name = name
        self.breed = Breed(breedName: "")
	}

}
