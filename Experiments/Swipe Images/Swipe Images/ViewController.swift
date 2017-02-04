//
//  ViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 2/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // all one's are dynamic, all two's are static
    
    // everything about the image
    @IBOutlet weak var imageOne: UIImageView!
    var imageOneCenter = CGPoint(x: 0, y: 0)
    @IBOutlet weak var imageTwo: UIImageView!

    // everything about the border
    @IBOutlet weak var borderOne: UIView!
    var borderOneCenter = CGPoint(x: 0, y: 0)
    var borderRelativeCenter = CGPoint(x: 0, y: 0)
    @IBOutlet weak var borderTwo: UIView!
    
    // everything about the label
    @IBOutlet weak var labelOne: UILabel!
    var labelOneCenter = CGPoint(x: 0, y: 0)
    var labelRelativeCenter = CGPoint(x: 0, y: 0)
    @IBOutlet weak var labelTwo: UILabel!
    
    // touch locations
    var currentLocation = CGPoint(x: 0, y: 0)
    var previousLocation = CGPoint(x: 0, y: 0)
    
    // radius size
    let CORNER_RADIUS = 10
    
    func updateOne() {
        
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
        imageOne.center = imageOneCenter
        borderOne.center = borderOneCenter
        labelOne.center = labelOneCenter
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch! = touches.first
        
        previousLocation = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch! = touches.first
        
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
        
        let slope = CGFloat((imageOne.center.y - imageOneCenter.y) / (imageOne.center.x - imageOneCenter.x))
        
        // swipping left
        if (imageOne.center.x < imageOneCenter.x) {
        
            let outsideX = CGFloat(0 - IMAGE_HALF - OFFSET)
            let outsideY = CGFloat(slope * (outsideX - imageOneCenter.x) + imageOneCenter.y)
            
            // case to go back to center
            if  imageOne.center.x > imageOneCenter.x - MIN_X {
            
                imageOne.center = imageOneCenter
                borderOne.center = borderOneCenter
                labelOne.center = labelOneCenter
            }
            
            // case to slide to left
            else {
            
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseIn , animations: ({
                    
                    self.imageOne.center.x = outsideX
                    self.imageOne.center.y = outsideY
                    self.borderOne.center.x = outsideX
                    self.borderOne.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
                    self.labelOne.center.x = outsideX
                    self.labelOne.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
                    
                }), completion: {(value: Bool) -> Void in
                    
                    self.updateOne()
                })
            }
        }
        
        // swipping right
        else {
            
            let outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
            let outsideY = CGFloat(slope * (outsideX - imageOneCenter.x) + imageOneCenter.y)
            
            // case to go back to center
            if  imageOne.center.x < imageOneCenter.x + MIN_X {
                
                imageOne.center = imageOneCenter
                borderOne.center = borderOneCenter
                labelOne.center = labelOneCenter
            }
                
            // case to slide to right
            else {
                
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseOut, animations: ({
                    
                    self.imageOne.center.x = outsideX
                    self.imageOne.center.y = outsideY
                    self.borderOne.center.x = outsideX
                    self.borderOne.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
                    self.labelOne.center.x = outsideX
                    self.labelOne.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
                    
                }), completion: {(value: Bool) -> Void in
                    
                    self.updateOne()
                })
            }
        }
    }
    
    
    // when super like button pressed, supposed to shoot up
    @IBAction func superLikePressed(_ sender: Any) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(100)
        
        let outsideX = CGFloat(imageOneCenter.x)
        let outsideY = CGFloat(0 - IMAGE_HALF - OFFSET)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseOut, animations: ({
            
            self.imageOne.center.x = outsideX
            self.imageOne.center.y = outsideY
            self.borderOne.center.x = outsideX
            self.borderOne.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
            self.labelOne.center.x = outsideX
            self.labelOne.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
            
        }), completion: {(value: Bool) -> Void in
            
            self.updateOne()
        })
    }
    
    // when pressed go left
    @IBAction func dislikePressed(_ sender: Any) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        let outsideX = CGFloat(0 - IMAGE_HALF - OFFSET)
        let outsideY = CGFloat(imageOneCenter.y)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseOut, animations: ({
            
            self.imageOne.center.x = outsideX
            self.imageOne.center.y = outsideY
            self.borderOne.center.x = outsideX
            self.borderOne.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
            self.labelOne.center.x = outsideX
            self.labelOne.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
            
        }), completion: {(value: Bool) -> Void in
            
            self.updateOne()
        })
    }
    
    // when pressed go right
    @IBAction func likePressed(_ sender: Any) {
        
        let IMAGE_HALF : CGFloat = CGFloat(imageOne.frame.size.width / 2)
        let OFFSET = CGFloat(20)
        
        let outsideX = CGFloat(self.view.frame.size.width + IMAGE_HALF + OFFSET)
        let outsideY = CGFloat(imageOneCenter.y)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.curveEaseOut, animations: ({
            
            self.imageOne.center.x = outsideX
            self.imageOne.center.y = outsideY
            self.borderOne.center.x = outsideX
            self.borderOne.center.y = CGFloat(outsideY - self.borderRelativeCenter.y)
            self.labelOne.center.x = outsideX
            self.labelOne.center.y = CGFloat(outsideY - self.labelRelativeCenter.y)
            
        }), completion: {(value: Bool) -> Void in
            
            self.updateOne()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // configure imageOne
        imageOneCenter = imageOne.center
        imageOne.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        imageTwo.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        imageTwo.center = imageOneCenter
        
        // configure border
        borderOneCenter = borderOne.center
        borderOne.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        borderRelativeCenter = CGPoint(x: 0, y: imageOneCenter.y - borderOneCenter.y)
        borderTwo.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        borderTwo.center = borderOneCenter
        
        // configure label
        labelOneCenter = labelOne.center
        labelRelativeCenter = CGPoint(x: 0, y: imageOneCenter.y - labelOneCenter.y)
        labelTwo.center = labelOneCenter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

