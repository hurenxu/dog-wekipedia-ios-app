//
//  ViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 2/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // everything about the image
    @IBOutlet weak var imageOne: UIImageView!
    var centerLocation = CGPoint(x: 0, y: 0)

    // touch locations
    var currentLocation = CGPoint(x: 0, y: 0)
    var previousLocation = CGPoint(x: 0, y: 0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch! = touches.first
        
        previousLocation = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch! = touches.first
        
        currentLocation = touch.location(in: self.view)
     
        imageOne.center.x += currentLocation.x - previousLocation.x
        imageOne.center.y += currentLocation.y - previousLocation.y
        
        previousLocation = currentLocation
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let MIN_X : CGFloat = CGFloat(100)
        let IMAGE_QRT : CGFloat = CGFloat(imageOne.frame.size.width / 4)
        
        let touch : UITouch! = touches.first
        
        currentLocation = touch.location(in: self.view)
        
        // swipping left
        if (currentLocation.x < centerLocation.x) {
        
            // case to go back to center
            if  imageOne.center.x > centerLocation.x - MIN_X {
            
                imageOne.center = centerLocation
            
            }
            
            // case to disappear to left, need to figure out animation effect
            else {
            
                imageOne.center.x = 0 - IMAGE_QRT
            }
        }
        
        // swipping right
        else {
            
            // case to go back to center
            if  imageOne.center.x < centerLocation.x + MIN_X {
                
                imageOne.center = centerLocation
                
            }
                
            // case to disappear to right, need to figure out animation effect
            else {
                
                imageOne.center.x = self.view.frame.size.width + IMAGE_QRT
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerLocation = imageOne.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

