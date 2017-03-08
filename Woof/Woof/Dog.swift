import Foundation

class Dog{
    
    let dogID: String
	var name = ""
    let breed: Breed
    var age = 0
    var gender = ""
    let birthDate: Date
    var vaccination = Date()
    var color = ""
    var description = ""
    var image = ""
    
    init(dictionary: NSDictionary){
        dogID = (dictionary["dogID"] as? String)!
        name = (dictionary["name"] as? String) ?? ""
        breed = (dictionary["breed"] as? Breed)!
        age = (dictionary["age"] as? Int) ?? 0
        gender = (dictionary["gender"] as? String)!
        birthDate = (dictionary["birthDate"] as? Date)!
        vaccination = (dictionary["vaccination"] as? Date) ?? Date()
        color = (dictionary["color"] as? String) ?? ""
        description = (dictionary["description"] as? String) ?? ""
        image = (dictionary["image"] as? String) ?? ""
    }
    
    init(dogID: String, name: String, breed: Breed, birthDate: Date = Date(), age: Int = 0, gender: String = "", vaccination: Date = Date(), color: String = "", description: String = "", image: String){
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
    func updateDogProfile(){
        let dao = DataAccessObject()
        dao.updateDog(dog: self)
    }
    func deleteDogProfileEntry() {
        let dao = DataAccessObject()
        dao.deleteDog(dog: self)
    }
    func viewDog(dog: Dog) -> Any {
        let dao = DataAccessObject()
        return dao.viewDog(dog: self)
    }
}
