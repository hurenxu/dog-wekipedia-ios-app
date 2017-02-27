//
//  ViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 2/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // TODO: update sizes to be relative to screen's size
    
    // all one's are dynamic, all two's are static
    
    // the size of the phone
    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // everything about the image
    let IMAGE_CENTER = CGPoint(x: 15, y: 20)
    let IMAGE_WIDTH = CGFloat(340)
    let IMAGE_HEIGHT = CGFloat(425)
    var imageOne: UIImageView! = nil
    var imageTwo: UIImageView! = nil

    // everything about the border
    let BORDER_CENTER = CGPoint(x: 15, y: 60)
    let BORDER_WIDTH = CGFloat(340)
    let BORDER_HEIGHT = CGFloat(465)
    var borderRelativeCenter: CGPoint! = nil
    var borderOne: UIView! = nil
    var borderTwo: UIView! = nil
    
    // everything about the label
    let LABEL_CENTER = CGPoint(x: 15, y: 465)
    let LABEL_WIDTH = CGFloat(340)
    let LABEL_HEIGHT = CGFloat(40)
    let FONT_SIZE = CGFloat(35)
    let FONT = "Arial"
    var labelRelativeCenter = CGPoint(x: 0, y: 0)
    var labelOne: UILabel = UILabel()
    var labelTwo: UILabel = UILabel()
    
    // touch locations
    var currentLocation = CGPoint(x: 0, y: 0)
    var previousLocation = CGPoint(x: 0, y: 0)
    
    
    let BREED_COUNT = 10
    var tenBreeds = [Breed]()
    
    var current : Breed! = nil;
    var next : Breed! = nil;
    
    // radius size
    let CORNER_RADIUS = 10
    
    func updateImages() {
        
        // update all one's
        if labelOne.text == "Dachshund" {
            
            imageOne.image = UIImage(named: "Chihuahua")
            labelOne.text = "Chihuahua"
        }
            
        else {
            
            imageOne.image = UIImage(named: "Dachshund")
            labelOne.text = "Dachshund"
        }
        
        // centered all one's
        imageOne.center = imageTwo.center
        borderOne.center = borderTwo.center
        labelOne.center = labelTwo.center
        
        // update all two's
        if labelOne.text == "Dachshund" {
            
            imageTwo.image = UIImage(named: "Chihuahua")
            labelTwo.text = "Chihuahua"
        }
            
        else {
            
            imageTwo.image = UIImage(named: "Dachshund")
            labelTwo.text = "Dachshund"
        }
    }
    
    func slideOut(_ outsideX: CGFloat, _ outsideY: CGFloat) {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseIn , animations: ({
            
            self.imageOne.center.x = outsideX
            self.imageOne.center.y = outsideY
            self.borderOne.center.x = outsideX
            self.borderOne.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
            self.labelOne.center.x = outsideX
            self.labelOne.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
            
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
     
        imageOne.center.x += distanceX
        imageOne.center.y += distanceY
        borderOne.center.x += distanceX
        borderOne.center.y += distanceY
        labelOne.center.x += distanceX
        labelOne.center.y += distanceY
        
        previousLocation = currentLocation
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let MIN_X : CGFloat = CGFloat(50)
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        let slope = CGFloat((imageOne.center.y - imageTwo.center.y) / (imageOne.center.x - imageTwo.center.x))
        
        // swipping left
        if (imageOne.center.x < IMAGE_CENTER.x) {
        
            let outsideX = CGFloat(0 - IMAGE_HALF - OFFSET)
            let outsideY = CGFloat(slope * (outsideX - imageTwo.center.x) + imageTwo.center.y)
            
            // case to go back to center
            if  imageOne.center.x > imageTwo.center.x - MIN_X {
            
                imageOne.center = imageTwo.center
                borderOne.center = borderTwo.center
                labelOne.center = labelTwo.center
            }
            
            // case to slide to left
            else {
            
                slideOut(outsideX, outsideY)
            }
        }
        
        // swipping right
        else {
            
            let outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
            let outsideY = CGFloat(slope * (outsideX - imageTwo.center.x) + imageTwo.center.y)
            
            // case to go back to center
            if  imageOne.center.x < imageTwo.center.x + MIN_X {
                
                imageOne.center = imageTwo.center
                borderOne.center = borderTwo.center
                labelOne.center = labelTwo.center
            }
                
            // case to slide to right
            else {
                
                slideOut(outsideX, outsideY)
            }
        }
    }
    
    
    // when super like button pressed, supposed to shoot up
    @IBAction func superLikePressed(_ sender: Any) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(100)
        
        let outsideX = CGFloat(imageTwo.center.x)
        let outsideY = CGFloat(0 - IMAGE_HALF - OFFSET)
        
        slideOut(outsideX, outsideY)
    }
    
    // when pressed go left
    @IBAction func dislikePressed(_ sender: Any) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        let outsideX = CGFloat(0 - IMAGE_HALF - OFFSET)
        let outsideY = CGFloat(imageTwo.center.y)
        
        slideOut(outsideX, outsideY)
    }
    
    // when pressed go right
    @IBAction func likePressed(_ sender: Any) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        let outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
        let outsideY = CGFloat(imageTwo.center.y)
        
        slideOut(outsideX, outsideY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Request 10 Breeds information
        
        // TODO CHECK THE METHOD CALL
        var tempBreed : Breed! = nil
        
        for index 1...BREED_COUNT {
            
            tenBreeds.append(tempBreed.newBreed())
        }
        
        borderRelativeCenter = CGPoint(x: 0, y: IMAGE_CENTER.y - BORDER_CENTER.y)
        labelRelativeCenter = CGPoint(x: 0, y: LABEL_CENTER.y - IMAGE_CENTER.y)
        
        // two static: border, image, and label
        borderTwo = UIView(frame: CGRect(x: BORDER_CENTER.x, y: BORDER_CENTER.y, width: BORDER_WIDTH, height: BORDER_HEIGHT))
        borderTwo.backgroundColor = UIColor.white
        borderTwo.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        self.view.addSubview(borderTwo)
        
        imageTwo = UIImageView(image: UIImage(named: "Chihuahua"))
        imageTwo.frame = CGRect(x: IMAGE_CENTER.x, y: IMAGE_CENTER.y, width: IMAGE_WIDTH, height: IMAGE_HEIGHT)
        imageTwo.roundCorners(corners: [.topLeft, .topRight], radius: CGFloat(CORNER_RADIUS))
        self.view.addSubview(imageTwo)
        
        labelTwo.text = "Chihuahua"
        labelTwo.frame = CGRect(x: LABEL_CENTER.x, y: LABEL_CENTER.y, width: LABEL_WIDTH, height: LABEL_HEIGHT)
        labelTwo.font = UIFont(name: FONT, size: FONT_SIZE)
        labelTwo.textAlignment = NSTextAlignment.center
        self.view.addSubview(labelTwo)
        
        // one dynamic: border, image, and label
        borderOne = UIView(frame: CGRect(x: BORDER_CENTER.x, y: BORDER_CENTER.y, width: BORDER_WIDTH, height: BORDER_HEIGHT))
        borderOne.backgroundColor = UIColor.white
        borderOne.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        self.view.addSubview(borderOne)
        
        imageOne = UIImageView(image: UIImage(named: "Dachshund"))
        imageOne.frame = CGRect(x: IMAGE_CENTER.x, y: IMAGE_CENTER.y, width: IMAGE_WIDTH, height: IMAGE_HEIGHT)
        imageOne.roundCorners(corners: [.topLeft, .topRight], radius: CGFloat(CORNER_RADIUS))
        self.view.addSubview(imageOne)
        
        labelOne.text = "Dachshund"
        labelOne.frame = CGRect(x: LABEL_CENTER.x, y: LABEL_CENTER.y, width: LABEL_WIDTH, height: LABEL_HEIGHT)
        labelOne.font = UIFont(name: FONT, size: FONT_SIZE)
        labelOne.textAlignment = NSTextAlignment.center
        self.view.addSubview(labelOne)
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

