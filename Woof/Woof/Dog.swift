import Foundation

struct Dog{

	let name: String
    let breed: Breed

	init(name: String){
		self.name = name
        breed = Breed(breedName: "")
	}

}
