//
//  ViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 2/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    // the size of the phone
    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // offsets
    let IMAGE_OFFSET: Int = 30
    let BORDER_OFFSET: Int = 40
    let LABEL_OFFSET: Int = 390
    let MIDDLE_BUTTON_OFFSET: Int = 85
    let SIDE_BUTTON_OFFSET: Int = 35
    
    // math constants
    let HALF: Int = 2
    let DOUBLE: Int = 2
    
    // everything about the image
    let IMAGE_SIZE: CGSize = CGSize(width: 345, height: 425)
    var imageStatic: UIImageView! = nil
    var imageDynamic: UIImageView! = nil

    // everything about the border
    let BORDER_SIZE: CGSize = CGSize(width: 345, height: 465)
    var borderStatic: UIView! = nil
    var borderDynamic: UIView! = nil
    var borderRelativeCenter: CGPoint! = nil
    
    // everything about the label
    let LABEL_SIZE: CGSize = CGSize(width: 345, height: 60)
    let FONT_SIZE = CGFloat(35)
    let FONT = "Noteworthy"
    var labelStatic: UILabel = UILabel()
    var labelDynamic: UILabel = UILabel()
    var labelRelativeCenter: CGPoint! = nil
    
    // touch locations for dragging
    var currentLocation = CGPoint(x: 0, y: 0)
    var previousLocation = CGPoint(x: 0, y: 0)
    
    // Buttons
    let BUTTON_SIZE: CGSize = CGSize(width: 75, height: 70)
    let CENTER_BUTTON_SIZE: CGSize = CGSize(width: 225, height: 100)
    var leftButton: UIButton! = nil
    var rightButton: UIButton! = nil
    var statsButton: UIButton! = nil
    
    // breed information
    let BREED_COUNT: Int = 10
    var currentBreed: Breed! = nil
    var nextBreed: Breed! = nil
    var breedArray: [Breed] = [Breed]()
    var likeBreeds: [Int] = [Int]()
    var nextBreeds: [Int] = [Int]()
    var arrayOfBreedName: [String] = [String]()
    
    // the dictionary and array of top three filters
    var likeFilters: [String: Int]! = [String:Int]()
    var topFilters: [String] = [String]()
    let MAX_FILTERS: Int = 3
    
    var allBreeds: [Breed] = [Breed]()
    
    // the current index
    var index: Int = 0
    
    var done: Bool = false
    
    // radius size
    let CORNER_RADIUS = 10
    
    func updateImages() {
        
        if !done {
            
            currentBreed = breedArray[index]
            index += 1
            
            // update dynamic
            imageDynamic.image = UIImage(named: currentBreed.getImage())
            labelDynamic.text = currentBreed.getBreedName()
            
            // centered all dynamic
            imageDynamic.center = imageStatic.center
            borderDynamic.center = borderStatic.center
            labelDynamic.center = labelStatic.center
        }
        
        else {
            
            imageDynamic.isHidden = true
            labelDynamic.isHidden = true
            borderDynamic.isHidden = true
            
            // storeFilters()
        }
        
        if index == breedArray.count {
            
            imageStatic.isHidden = true
            labelStatic.isHidden = true
            borderStatic.isHidden = true
            
            done = true
        }
        
        else {
            
            nextBreed = breedArray[index]
            
            // update static if possible
            imageStatic.image = UIImage(named: nextBreed.getImage())
            labelStatic.text = nextBreed.getBreedName()
        }
    }
    
    func slideOut(_ outsideX: CGFloat, _ outsideY: CGFloat) {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseIn , animations: ({
            
            self.imageDynamic.center.x = outsideX
            self.imageDynamic.center.y = outsideY
            self.borderDynamic.center.x = outsideX
            self.borderDynamic.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
            self.labelDynamic.center.x = outsideX
            self.labelDynamic.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
            
        }), completion: {(value: Bool) -> Void in
            
            self.updateImages()
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch! = touches.first
        
        previousLocation = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch! = touches.first
        
        currentLocation = touch.location(in: self.view)
        
        let distanceX = CGFloat(currentLocation.x - previousLocation.x)
        let distanceY = CGFloat(currentLocation.y - previousLocation.y)
     
        imageDynamic.center.x += distanceX
        imageDynamic.center.y += distanceY
        borderDynamic.center.x += distanceX
        borderDynamic.center.y += distanceY
        labelDynamic.center.x += distanceX
        labelDynamic.center.y += distanceY
        
        previousLocation = currentLocation
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let MIN_X : CGFloat = CGFloat(50)
        let IMAGE_HALF : CGFloat = CGFloat(imageDynamic.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        let slope = CGFloat((imageDynamic.center.y - imageStatic.center.y) / (imageDynamic.center.x - imageStatic.center.x))
        
        // swipping left
        if (imageDynamic.center.x < imageStatic.center.x) {
        
            let outsideX = CGFloat(0 - IMAGE_HALF - OFFSET)
            let outsideY = CGFloat(slope * (outsideX - imageStatic.center.x) + imageStatic.center.y)
            
            // case to go back to center
            if  imageDynamic.center.x > imageStatic.center.x - MIN_X {
            
                imageDynamic.center = imageStatic.center
                borderDynamic.center = borderStatic.center
                labelDynamic.center = labelStatic.center
            }
            
            // case to slide to left
            else {
            
                // slide out then append the current index to likeBreeds
                slideOut(outsideX, outsideY)
                likeBreeds.append(index)
            }
        }
        
        // swipping right
        else {
            
            let outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
            let outsideY = CGFloat(slope * (outsideX - imageStatic.center.x) + imageStatic.center.y)
            
            // case to go back to center
            if  imageDynamic.center.x < imageStatic.center.x + MIN_X {
                
                imageDynamic.center = imageStatic.center
                borderDynamic.center = borderStatic.center
                labelDynamic.center = labelStatic.center
            }
                
            // case to slide to right
            else {
                
                // slide out then append the current index to nextBreeds
                slideOut(outsideX, outsideY)
                nextBreeds.append(index)
            }
        }
    }
    
    // when pressed go left or right
    @IBAction func sidePressed(sender: UIButton) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageDynamic.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        var outsideX: CGFloat! = nil
        var outsideY: CGFloat! = nil
        
        if sender == leftButton {
            
            outsideX = CGFloat(0 - IMAGE_HALF - OFFSET)
            outsideY = CGFloat(imageStatic.center.y)
            likeBreeds.append(index)
        }
        
        else if sender == rightButton {
            
            outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
            outsideY = CGFloat(imageStatic.center.y)
            nextBreeds.append(index)
        }
        
        slideOut(outsideX, outsideY)
    }
    
    // when pressed go left or right
    @IBAction func centerPressed(sender: UIButton) {
        
        print("switch to stats page")
        
        // pass the data
        
       //  self.navigationController?.pushViewController(statsVC, animated: true)
        
        // switch page
        let statisticsViewController: StatsViewController = StatsViewController()
        //statisticsViewController.topFilters = topFilters
        //statisticsViewController.likeFilters = likeFilters
        navigationController?.pushViewController(statisticsViewController, animated: true)
        self.present(statisticsViewController, animated: true, completion: nil)
    }
    
    // find top three tags
    func storeFilters() {
        
        for breedIndex in likeBreeds {
            
            // get the current breed
            let myBreed: Breed = breedArray[breedIndex]
            
            likeFilters[myBreed.getPersonality()]! += 1
            likeFilters[myBreed.getOrigin()]! += 1
            likeFilters[myBreed.getGroup()]! += 1
            likeFilters[myBreed.getHead()]! += 1
            likeFilters[myBreed.getBody()]! += 1
            likeFilters[myBreed.getEars()]! += 1
            // likeFilters[myBreed.getHair()] += 1
            likeFilters[myBreed.getTail()]! += 1
            likeFilters[myBreed.getShedding()]! += 1
            likeFilters[myBreed.getGrooming()]! += 1
        }
        
        // determine the top filters
        for keyValuePair in likeFilters {
            
            // topFilters doesn't have 3 elements yet
            if topFilters.count != MAX_FILTERS {
                
                topFilters.append(keyValuePair.key)
            }
            
            else {
                
                // start smallest key at the first element
                var indexOfSmallest: Int = 0
                
                // get the smallest key for replacement
                for i in 1...topFilters.count - 1 {
                    
                    if likeFilters[topFilters[i]]! < likeFilters[topFilters[indexOfSmallest]]! {
                        
                        indexOfSmallest = i
                    }
                }
                
                // if the current value is greater than smallestKey's value, then replace it
                if keyValuePair.value > likeFilters[topFilters[indexOfSmallest]]! {
                    
                    topFilters[indexOfSmallest] = keyValuePair.key
                }
            }
        }
    }
    
    // select Breed object that user hasn't liked yet
    func populateBreedArray() -> Int {
        
        // check the number of breeds, user has previously liked
        /**if user.favoriteDogBreeds.count == allBreeds.count {
            
            // error handling, use has liked all breeds
            print("Error, all breeds have been liked")
            
            return -1
        }*/
        
        //else {
        
            var i: Int = 0
            
            // while breed count hasn't been reached (10) and if there is breed to choose, keep looking
            //while i < BREED_COUNT && user.favoriteDogBreeds.count + breedArray.count < allBreeds.count {
            while i < BREED_COUNT {
                
                // get a random index in the all breeds array
                let randomIndex:UInt32 = arc4random_uniform(UInt32(allBreeds.count))
                
                // get the string of the current breed
                let currentBreedName: String = allBreeds[Int(randomIndex)].getBreedName()
                
                // if user didn't like this breed and it's not in the current list, add it
                // if !user.favoriteDogBreeds.contains(currentBreedName) && !arrayOfBreedName.contains(currentBreedName) {
                if !arrayOfBreedName.contains(currentBreedName) {
                    
                    // append the breed and its name
                    breedArray.append(allBreeds[Int(randomIndex)])
                    arrayOfBreedName.append(currentBreedName)
                    
                    // increment i
                    i += 1
                }
            }
            
            return 0
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Request 10 Breeds information
        /**
        if populateBreedArray() == -1 {
        
            // there is error, print error message, then go back to homepage when OK has been clicked
        }*/
            
        // delete these when functionalities have been connected
        arrayOfBreedName = ["Chihuahua", "Dachshund", "Akita", "Alaskan Malamute", "American Eskimo Dog", "Beagle", "Biewer Terrier", "Border Collie", "Dalmatian", "Maltese"]
        
        for i in 0...arrayOfBreedName.count - 1 {
            
            breedArray.append(Breed(breedName: arrayOfBreedName[i], personality: "", origin: "", group: "", weight: "", height: "", head: "", body: "", ears: "", hair: "", tail: "", shedding: "", grooming: "", trainability: "", energyLevel: "", barkingLevel: "", lifeExpectancy: "", description: "", history: "", breeders: "", image: arrayOfBreedName[i]))
        }
        
        currentBreed = breedArray[index]
        index += 1
        nextBreed = breedArray[index]
        
        // colored background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        
        // the center of all components
        let IMAGE_CENTER = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(IMAGE_SIZE.width) / HALF, y: IMAGE_OFFSET)
        let BORDER_CENTER = CGPoint(x: IMAGE_CENTER.x, y: IMAGE_CENTER.y + CGFloat(BORDER_OFFSET))
        let LABEL_CENTER = CGPoint(x: IMAGE_CENTER.x, y: BORDER_CENTER.y + CGFloat(LABEL_OFFSET))
        let MIDDLE = CGPoint(x: Int(IMAGE_SIZE.width) / HALF + Int(IMAGE_CENTER.x), y: Int(LABEL_CENTER.y) + MIDDLE_BUTTON_OFFSET)
        let LEFT_CENTER = CGPoint(x: Int(MIDDLE.x) - SIDE_BUTTON_OFFSET - Int(BUTTON_SIZE.width), y: Int(MIDDLE.y))
        let RIGHT_CENTER = CGPoint(x: Int(MIDDLE.x) + SIDE_BUTTON_OFFSET, y: Int(MIDDLE.y))
        let CENTER_BUTTON = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(CENTER_BUTTON_SIZE.width) / HALF, y: Int(SCREEN_SIZE.height) / HALF - Int(CENTER_BUTTON_SIZE.height) / HALF)
        
        // realtive centers of border and label from image
        borderRelativeCenter = CGPoint(x: 0, y: IMAGE_CENTER.y - BORDER_CENTER.y)
        labelRelativeCenter = CGPoint(x: 0, y: LABEL_CENTER.y - IMAGE_CENTER.y)
        
        statsButton = UIButton(frame: CGRect(origin: CENTER_BUTTON, size: CENTER_BUTTON_SIZE))
        statsButton.backgroundColor = UIColor(red: 100.0/255.0, green: 120.0/255.0, blue: 150.0/255.0, alpha: 0.9)
        statsButton.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        statsButton.setTitle("View Statistics", for: UIControlState.normal)
        statsButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        statsButton.titleLabel?.font = UIFont(name: FONT, size: FONT_SIZE)
        statsButton.addTarget(self, action: #selector(self.centerPressed(sender:)), for: UIControlEvents.touchDown)
        
        // static: border, image, and label
        borderStatic = UIView(frame: CGRect(origin: BORDER_CENTER, size: BORDER_SIZE))
        borderStatic.backgroundColor = UIColor.white
        borderStatic.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        self.view.addSubview(borderStatic)
        
        imageStatic = UIImageView(image: UIImage(named: nextBreed.getImage()))
        imageStatic.frame = CGRect(origin: IMAGE_CENTER, size: IMAGE_SIZE)
        imageStatic.roundCorners(corners: [.topLeft, .topRight], radius: CGFloat(CORNER_RADIUS))
        self.view.addSubview(imageStatic)
        
        labelStatic.text = nextBreed.getBreedName()
        labelStatic.frame = CGRect(origin: LABEL_CENTER, size: LABEL_SIZE)
        labelStatic.font = UIFont(name: FONT, size: FONT_SIZE)
        labelStatic.textAlignment = NSTextAlignment.center
        self.view.addSubview(labelStatic)
        
        // dynamic: border, image, and label
        borderDynamic = UIView(frame: CGRect(origin: BORDER_CENTER, size: BORDER_SIZE))
        borderDynamic.backgroundColor = UIColor.white
        borderDynamic.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        self.view.addSubview(borderDynamic)
        
        imageDynamic = UIImageView(image: UIImage(named: currentBreed.getImage()))
        imageDynamic.frame = CGRect(origin: IMAGE_CENTER, size: IMAGE_SIZE)
        imageDynamic.roundCorners(corners: [.topLeft, .topRight], radius: CGFloat(CORNER_RADIUS))
        self.view.addSubview(imageDynamic)
        
        labelDynamic.text = currentBreed.getBreedName()
        labelDynamic.frame = CGRect(origin: LABEL_CENTER, size: LABEL_SIZE)
        labelDynamic.font = UIFont(name: FONT, size: FONT_SIZE)
        labelDynamic.textAlignment = NSTextAlignment.center
        self.view.addSubview(labelDynamic)
        
        // buttons set up
        leftButton = UIButton(frame: CGRect(origin: LEFT_CENTER, size: BUTTON_SIZE))
        leftButton.setBackgroundImage(UIImage(named: "Red Heart"), for: UIControlState.normal)
        leftButton.addTarget(self, action: #selector(self.sidePressed(sender:)), for: UIControlEvents.touchDown)
        self.view.addSubview(leftButton)
        
        rightButton = UIButton(frame: CGRect(origin: RIGHT_CENTER, size: BUTTON_SIZE))
        rightButton.setBackgroundImage(UIImage(named: "Arrow"), for: UIControlState.normal)
        rightButton.addTarget(self, action: #selector(self.sidePressed(sender:)), for: UIControlEvents.touchDown)
        self.view.addSubview(rightButton)
        self.view.addSubview(statsButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// the extra function to round only specified corners
extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {

        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

