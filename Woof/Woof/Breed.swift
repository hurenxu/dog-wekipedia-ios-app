import Foundation

class Breed{

	let breedName: String
    var personality = ""
    var origin = ""
    //Group :"Herding"; "Hound"; "Non-sporting"; "Sporting"; "Terrier"; "Toy"; "Working"
    var group = ""
    var weight = ""
    var height = ""
    var head = ""
    //Body size :"Large" ; "Medium" ; "Small"
    var body = ""
    var ears = ""
    //Hair length :"Long"; "Short"
    var hair = ""
    var tail = ""
    var shedding = ""
    var grooming = ""
    //Trainability: "Bright"; "Average"; "Fair"
    var trainability = ""
    //"Active"; "Chill"
    var energyLevel = ""
    var barkingLevel = ""
    var lifeExpectancy = ""
    var description = ""
    var history = ""
    var breeders = ""
    var image = ""
    
    init(dictionary: NSDictionary) {
        breedName = (dictionary["breedName"] as? String)!
        personality = (dictionary["personality"]as? String) ?? ""
        origin = (dictionary["origin"] as? String) ?? ""
        group = (dictionary["group"] as? String) ?? ""
        weight = (dictionary["weight"] as? String) ?? ""
        height = (dictionary["height"] as? String) ?? ""
        head = (dictionary["head"] as? String) ?? ""
        body = (dictionary["body"] as? String) ?? ""
        ears = (dictionary["ears"] as? String) ?? ""
        hair = (dictionary["hair"] as? String) ?? ""
        tail = (dictionary["tail"] as? String) ?? ""
        shedding = (dictionary["shedding"] as? String) ?? ""
        grooming = (dictionary["grooming"] as? String) ?? ""
        trainability = (dictionary["trainability"] as? String) ?? ""
        energyLevel = (dictionary["energyLevel"] as? String) ?? ""
        barkingLevel = (dictionary["barkingLevel"] as? String) ?? ""
        lifeExpectancy = (dictionary["lifeExpectancy"] as? String) ?? ""
        description = (dictionary["description"] as? String) ?? ""
        history = (dictionary["histrory"] as? String) ?? ""
        breeders = (dictionary["breeders"] as? String) ?? ""
        image = (dictionary["image"] as? String) ?? ""
    }

    init(breedName: String, image: String, personality: String = "", origin: String = "",
         group: String = "", weight: String = "", height: String = "",
         head: String = "", body: String = "", ears: String = "",
         hair: String = "", tail: String = "", shedding: String = "",
         grooming: String = "", trainability: String = "", energyLevel: String = "",
         barkingLevel: String = "", lifeExpectancy: String = "", description: String = "",
         history: String = "", breeders: String = ""){
		self.breedName = breedName
        self.personality = personality
        self.origin = origin
        self.group = group
        self.weight = weight
        self.height = height
        self.head = head
        self.body = body
        self.ears = ears
        self.hair = hair
        self.tail = tail
        self.shedding = shedding
        self.grooming = grooming
        self.trainability = trainability
        self.energyLevel = energyLevel
        self.barkingLevel = barkingLevel
        self.lifeExpectancy = lifeExpectancy
        self.description = description
        self.history = history
        self.breeders = breeders
        self.image = image
	}
    
    
    func getBreedName() -> String {
        return self.breedName
    }
    
    func getPersonality() -> String {
        return self.personality
    }
    
    func getOrigin() -> String {
        return self.origin
    }
    
    func getGroup() -> String {
        return self.group
    }
    
    func getWeight() -> String {
        return self.weight
    }
    
    func getHead() -> String {
        return self.head
    }
    
    func getBody() -> String {
        return self.body
    }
    
    func getEars() -> String {
        return self.ears
    }
    
    func getTail() -> String {
        return self.tail
    }
    
    func getShedding() -> String {
        return self.shedding
    }
    
    func getGrooming() -> String {
        return self.grooming
    }
    
    func getTrainability() -> String {
        return self.trainability
    }
    
    func getEnergyLevel() -> String {
        return self.energyLevel
    }
    
    func getBarkingLevel() -> String {
        return self.barkingLevel
    }
    
    func getLifeExpectancy() -> String {
        return self.lifeExpectancy
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func getHistory() -> String {
        return self.history
    }
    
    func getBreeders() -> String {
        return self.breeders
    }
    
    func getImage() -> String {
        return self.image
    }
    
    func setPersonality(personality: String) {
        self.personality = personality
    }
    
    func setImage(imageurl: String) {
        self.image = imageurl
    }
	
}
