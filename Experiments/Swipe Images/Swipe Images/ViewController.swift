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
    
    // the size of the phone
    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    let ORIGIN: CGPoint = CGPoint(x: 0, y: 0)
    
    // offsets
    let IMAGE_OFFSET: Int = 30
    let BORDER_OFFSET: Int = 40
    let LABEL_OFFSET: Int = 405
    let MIDDLE_BUTTON_OFFSET: Int = 70
    let SIDE_BUTTON_OFFSET: Int = 110
    
    // math constants
    let HALF: Int = 2
    
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
    let LABEL_SIZE: CGSize = CGSize(width: 345, height: 40)
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
    var middleButton: UIButton! = nil
    var leftButton: UIButton! = nil
    var rightButton: UIButton! = nil
    
    /**
    let BREED_COUNT = 10
    var tenBreeds = [Breed]()
    
    var current : Breed! = nil;
    var next : Breed! = nil;
    */
    
    // radius size
    let CORNER_RADIUS = 10
    
    func updateImages() {
        
        // update all dynamic
        if labelDynamic.text == "Dachshund" {
            
            imageDynamic.image = UIImage(named: "Chihuahua")
            labelDynamic.text = "Chihuahua"
        }
            
        else {
            
            imageDynamic.image = UIImage(named: "Dachshund")
            labelDynamic.text = "Dachshund"
        }
        
        // centered all dynamic
        imageDynamic.center = imageStatic.center
        borderDynamic.center = borderStatic.center
        labelDynamic.center = labelStatic.center
        
        // update all two's
        if labelDynamic.text == "Dachshund" {
            
            imageStatic.image = UIImage(named: "Chihuahua")
            labelStatic.text = "Chihuahua"
        }
            
        else {
            
            imageStatic.image = UIImage(named: "Dachshund")
            labelStatic.text = "Dachshund"
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
            
                slideOut(outsideX, outsideY)
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
                
                slideOut(outsideX, outsideY)
            }
        }
    }
    
    
    // when description button pressed, supposed to show description
    @IBAction func descriptionPressed(sender: UIButton) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageDynamic.frame.size.width / 2)
        let OFFSET = CGFloat(100)
        
        let outsideX = CGFloat(imageStatic.center.x)
        let outsideY = CGFloat(0 - IMAGE_HALF - OFFSET)
        
        slideOut(outsideX, outsideY)
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
        }
        
        else if sender == rightButton {
            
            outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
            outsideY = CGFloat(imageStatic.center.y)
        }
        
        slideOut(outsideX, outsideY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Request 10 Breeds information
        
        // TODO CHECK THE METHOD CALL
        //var tempBreed : Breed! = nil
        
        //for index 1...BREED_COUNT {
            
            //tenBreeds.append(tempBreed.newBreed())
        //}
        
        // colored background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        
        // the center of all components
        let IMAGE_CENTER = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(IMAGE_SIZE.width) / HALF, y: IMAGE_OFFSET)
        let BORDER_CENTER = CGPoint(x: IMAGE_CENTER.x, y: IMAGE_CENTER.y + CGFloat(BORDER_OFFSET))
        let LABEL_CENTER = CGPoint(x: IMAGE_CENTER.x, y: BORDER_CENTER.y + CGFloat(LABEL_OFFSET))
        let MIDDLE_CENTER = CGPoint(x: Int(IMAGE_SIZE.width) / HALF + Int(IMAGE_CENTER.x) - Int(BUTTON_SIZE.width) / HALF, y: Int(LABEL_CENTER.y) + MIDDLE_BUTTON_OFFSET)
        let LEFT_CENTER = CGPoint(x: Int(MIDDLE_CENTER.x) - SIDE_BUTTON_OFFSET, y: Int(MIDDLE_CENTER.y))
        let RIGHT_CENTER = CGPoint(x: Int(MIDDLE_CENTER.x) + SIDE_BUTTON_OFFSET, y: Int(MIDDLE_CENTER.y))
        
        // realtive centers of border and label from image
        borderRelativeCenter = CGPoint(x: 0, y: IMAGE_CENTER.y - BORDER_CENTER.y)
        labelRelativeCenter = CGPoint(x: 0, y: LABEL_CENTER.y - IMAGE_CENTER.y)
        
        // static: border, image, and label
        borderStatic = UIView(frame: CGRect(origin: BORDER_CENTER, size: BORDER_SIZE))
        borderStatic.backgroundColor = UIColor.white
        borderStatic.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        self.view.addSubview(borderStatic)
        
        imageStatic = UIImageView(image: UIImage(named: "Chihuahua"))
        imageStatic.frame = CGRect(origin: IMAGE_CENTER, size: IMAGE_SIZE)
        imageStatic.roundCorners(corners: [.topLeft, .topRight], radius: CGFloat(CORNER_RADIUS))
        self.view.addSubview(imageStatic)
        
        labelStatic.text = "Chihuahua"
        labelStatic.frame = CGRect(origin: LABEL_CENTER, size: LABEL_SIZE)
        labelStatic.font = UIFont(name: FONT, size: FONT_SIZE)
        labelStatic.textAlignment = NSTextAlignment.center
        self.view.addSubview(labelStatic)
        
        // dynamic: border, image, and label
        borderDynamic = UIView(frame: CGRect(origin: BORDER_CENTER, size: BORDER_SIZE))
        borderDynamic.backgroundColor = UIColor.white
        borderDynamic.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        self.view.addSubview(borderDynamic)
        
        imageDynamic = UIImageView(image: UIImage(named: "Dachshund"))
        imageDynamic.frame = CGRect(origin: IMAGE_CENTER, size: IMAGE_SIZE)
        imageDynamic.roundCorners(corners: [.topLeft, .topRight], radius: CGFloat(CORNER_RADIUS))
        self.view.addSubview(imageDynamic)
        
        labelDynamic.text = "Dachshund"
        labelDynamic.frame = CGRect(origin: LABEL_CENTER, size: LABEL_SIZE)
        labelDynamic.font = UIFont(name: FONT, size: FONT_SIZE)
        labelDynamic.textAlignment = NSTextAlignment.center
        self.view.addSubview(labelDynamic)
        
        // set up the buttons
        middleButton = UIButton(frame: CGRect(origin: MIDDLE_CENTER, size: BUTTON_SIZE))
        middleButton.setBackgroundImage(UIImage(named: "Dog Emoji"), for: UIControlState.normal)
        middleButton.addTarget(self, action: #selector(self.descriptionPressed(sender:)), for: UIControlEvents.touchDown)
        self.view.addSubview(middleButton)
        
        leftButton = UIButton(frame: CGRect(origin: LEFT_CENTER, size: BUTTON_SIZE))
        leftButton.setBackgroundImage(UIImage(named: "Red Heart"), for: UIControlState.normal)
        leftButton.addTarget(self, action: #selector(self.sidePressed(sender:)), for: UIControlEvents.touchDown)
        self.view.addSubview(leftButton)
        
        rightButton = UIButton(frame: CGRect(origin: RIGHT_CENTER, size: BUTTON_SIZE))
        rightButton.setBackgroundImage(UIImage(named: "Arrow"), for: UIControlState.normal)
        rightButton.addTarget(self, action: #selector(self.sidePressed(sender:)), for: UIControlEvents.touchDown)
        self.view.addSubview(rightButton)
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

