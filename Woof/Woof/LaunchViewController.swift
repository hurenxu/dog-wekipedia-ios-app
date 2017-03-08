//
//  LaunchViewController.swift
//  Woof
//
//  Created by lilusha on 07/03/2017.
//  Copyright © 2017 Woof. All rights reserved.
//

import Foundation
import UIKit


class LaunchViewController: UIViewController {
//    @IBOutlet weak var eyeImageView: UIImageView!
    
    @IBOutlet weak var eyeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let logoImage: [UIImage] = [
            UIImage(named: "eye.jpg")!,
            UIImage(named: "launch.png")!
        ]
        
        eyeImageView.animationImages = logoImage
        
        eyeImageView.animationDuration = 4.0
        
        eyeImageView.animationRepeatCount = 2
        
        eyeImageView.startAnimating()
        
        if (!eyeImageView.isAnimating) {
            
            self.performSegue(withIdentifier: "showlogin", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
