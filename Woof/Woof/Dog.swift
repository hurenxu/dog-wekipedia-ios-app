import Foundation

class Dog{
    
    var dogID = ""
    var name = ""
    var breed: Breed!
    var age = ""
    var gender = ""
    let birthDate: Date
    var vaccination = Date()
    var color = ""
    var description = ""
    var image = ""
    
    
    init(dogID: String, name: String, breed: Breed, birthDate: Date = Date(), age: String = "", gender: String = "", vaccination: Date = Date(), color: String = "", description: String = "", image: String){
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
    
    init(dictionary: NSDictionary) {
        
        dogID = (dictionary["dogID"] as? String) ?? ""
        name = (dictionary["name"] as? String)!
        let breedname = (dictionary["breed"] as? String)!
        let birthDate = (dictionary["birthDate"] as? String)!
        age = (dictionary["age"] as? String)!
        gender = (dictionary["gender"] as? String)!
        let vaccination = (dictionary["vaccination"] as? String)!
        color = (dictionary["color"] as? String)!
        description = (dictionary["description"] as? String)!
        image = (dictionary["image"] as? String)!
        
        for breed in Functionalities.breedList {
            if (breed.getBreedName() == breedname) {
                self.breed = breed
            }
        }
        
        if self.breed == nil {
            self.breed = Breed(breedName: breedname, popularity: "", origin: "", group: "", size: "", type: "", lifeExpectancy: "", colors: "", litterSize: "", price: "", barkingLevel: "", childFriendly: "", breeders: "", image: "")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        self.birthDate = dateFormatter.date(from: birthDate)!
        self.vaccination = dateFormatter.date(from: vaccination)!
        
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
    func getAge() -> String{
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
    
    func setAge(age: String){
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
