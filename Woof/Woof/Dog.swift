import Foundation

class Dog{
    
    let dogID: String
	var name: String
    let breed: Breed
    var age: Int
    let gender: String
    let birthDate: Date
    var vaccination: Date
    var color: String
    var description: String
    var image: String
    
    
    init(dogID: String, name: String, breed: Breed, birthDate: Date, age: Int, gender: String, vaccination: Date, color: String, description: String, image: String){
		self.dogID = dogID
        self.name = name
        self.breed = breed
        self.age = age
        self.gender = gender
        self.birthDate = birthDate
        self.vaccination = vaccination
        self.color = color
        self.description = description
        self.image = image
	}
    
    func getBreed() -> Breed{
        return breed
    }
    
    func getBreedName() -> String {
        return breed.getBreedName()
    }
    
    func getDogID() -> String {
        return self.dogID
    }
    func getName() -> String{
        return name
    }
    func getAge() -> Int{
        return age
    }
    func getGender() -> String{
        return gender
    }
    func getBirthDate() -> Date{
        return birthDate
    }
    func getVaccination() -> Date{
        return vaccination
    }
    func getColor() -> String{
        return color
    }
    func getDescription() -> String{
        return description
    }
    func getImage() -> String{
        return image
    }
    
    func setAge(age: Int){
        self.age = age
    }
    
    func setImage(imageUrl: String){
        self.image = imageUrl
    }
    
    func setColor( color: String){
        self.color = color
    }
    
    func setVaccinationDate( vacDate: Date) {
        self.vaccination = vacDate
    }

    func setDescription( des: String) {
        self.description = des
    }
    
    func addDogProfileEntry() {
        let dao = DataAccessObject()
        dao.addDog(dog: self)
    }

}
