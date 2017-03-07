import Foundation

class Breed{

	let breedName: String
    var popularity = ""
    var origin = ""
    //Group :"Herding"; "Hound";"Non Sporting"; "Sporting"; "Terrier"; "Toy"; "Working"
    var group = ""
    //Body size :"Large" ; "Medium" ; "Small"
    var size = ""
    var type = ""
    var lifeExpectancy = ""
    //Personality: "Alert"; "Confident"; "Courageous"; "Curious"; "Intelligent"; "Loyal"
    //Personality(cont'd): "Obedient"; "Watchful";"Friendly";"Kind";"Reliable"; "Loving"; "Social"; "Sweet"; "Gentle"; "Independent"; "Lively"; "Affectionate";
    //Personality(cont'd): "Playful"; "Atheletic"; "Gentle"; "Easygoing"; "Keen"; "Aggressive"; "Energetic"; "Active";
    //Personality(cont'd): "Instinctual"; "Fearless"; "Protective"; "Good-natured"; "Trainable"; "Brave"; "Bright"; "Boisterous"; "Bold"; "Cooperative"; "Outgoing"; "Clever";
    //Personality(cont'd): "Stubborn"; "Devoted";"Reserved"; "Spirited"; "Cheerful"
    var personality = ""
    var height = ""
    var weight = ""
    //Colors: "Black"; "White"; "Red"; "Tan"; "Silver";"Chocolate"; "Yellow"; "Seal"; "Buff"
    //Colors(cont'd): "Golden"; "Brindle"; "Fawn"; "Beige"; "Blue";
    //Colors(cont'd): "Apricot"; "Brown"; "Cream"; "Gray"; "Mahogany"; "Rust"; "Liver"; "Loan"
    //Colors(cont'd): "Agouti"; "Sable"; "Mantle"; "Merle"; "Harlequin"; "Salt"; "Pepper"; "Blenheim"; "Ruby"; "Orange"
    var colors = ""
    var litterSize = ""
    var price = ""
    //Barking Level: "Frequent"; "Occasional"; "Rare";
    var barkingLevel = ""
    var childFriendly = ""
    //Grooming: "High"; "Moderate"; "Low"
    var grooming = ""
    //Shedding: "Minimal"; "Moderate"; "Constant"; "Seasonal"
    var shedding = ""
    //Trainability: "Easy"; "Average"; "Moderately Easy"
    var trainability = ""
    
    
    var breeders = ""
    var image = ""
    
    init(dictionary: NSDictionary) {
        breedName = (dictionary["breedName"] as? String)!
        popularity = (dictionary["popularity"]as? String) ?? ""
        origin = (dictionary["origin"] as? String) ?? ""
        group = (dictionary["group"] as? String) ?? ""
        size = (dictionary["size"] as? String) ?? ""
        type = (dictionary["type"] as? String) ?? ""
        lifeExpectancy = (dictionary["lifeExpectancy"] as? String) ?? ""
        personality = (dictionary["personality"]as? String) ?? ""
        height = (dictionary["height"] as? String) ?? ""
        weight = (dictionary["weight"] as? String) ?? ""
        colors = (dictionary["colors"] as? String) ?? ""
        litterSize = (dictionary["litterSize"] as? String) ?? ""
        price = (dictionary["price"] as? String) ?? ""
        barkingLevel = (dictionary["barkingLevel"] as? String) ?? ""
        childFriendly = (dictionary["childFriendly"] as? String) ?? ""
        grooming = (dictionary["grooming"] as? String) ?? ""
        shedding = (dictionary["shedding"] as? String) ?? ""
        trainability = (dictionary["trainability"] as? String) ?? ""
        
        breeders = (dictionary["breeders"] as? String) ?? ""
        image = (dictionary["image"] as? String) ?? ""
    }

    init(breedName: String, popularity: String, origin: String, group: String, size: String, type: String, lifeExpectancy: String, personality: String = "",
         height: String = "", weight: String = "",
         colors: String, litterSize: String, price: String, barkingLevel: String, childFriendly: String,
         
         grooming: String = "",shedding: String = "", trainability: String = "",
         breeders: String, image: String){
		self.breedName = breedName
        self.popularity = popularity
        self.origin = origin
        self.group = group
        self.size = size
        self.type = type
        self.lifeExpectancy = lifeExpectancy
        
        self.personality = personality
        self.height = height
        self.weight = weight
        self.colors = colors
        self.litterSize = litterSize
        self.price = price
        self.barkingLevel = barkingLevel
        self.childFriendly = childFriendly
        self.grooming = grooming
        self.shedding = shedding
        
        self.trainability = trainability
        
        
        self.breeders = breeders
        self.image = image
	}
    
    
    func getBreedName() -> String {
        return self.breedName
    }
    func getPopularity() -> String {
        return self.popularity
    }
    func getOrigin() -> String {
        return self.origin
    }
    func getGroup() -> String {
        return self.group
    }
    func getSize() -> String {
        return self.size
    }
    func getType() -> String {
        return self.type
    }
    func getLifeExpectancy() -> String {
        return self.lifeExpectancy
    }
    func getPersonality() -> String {
        return self.personality
    }
    
    /**
    func getHeight() -> String {
        return self.head
    }*/

    func getWeight() -> String {
        return self.weight
    }
    
    func getColors() -> String {
        return self.colors
    }
    
    func getLitterSize() -> String {
        return self.litterSize
    }
    func getPrice() -> String {
        return self.price
    }
    func getBarkingLevel() -> String {
        return self.barkingLevel
    }
    func getGrooming() -> String {
        return self.grooming
    }
    func getShedding() -> String {
        return self.shedding
    }
    func getTrainability() -> String {
        return self.trainability
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
