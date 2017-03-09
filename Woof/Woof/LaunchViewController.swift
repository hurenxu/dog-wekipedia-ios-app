//
//  LaunchViewController.swift
//  Woof
//
//  Created by lilusha on 07/03/2017.
//  Copyright © 2017 Woof. All rights reserved.
//

import Foundation
import Dispatch
import UIKit


class LaunchViewController: UIViewController {
//    @IBOutlet weak var eyeImageView: UIImageView!
    
    @IBOutlet weak var eyeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let logoImage: [UIImage] = [
            UIImage(named: "noeye.jpg")!,
            UIImage(named: "eye.jpg")!
        ]
        
        eyeImageView.animationImages = logoImage
        
        eyeImageView.animationDuration = 1.0
        
        eyeImageView.animationRepeatCount = 2
        
        eyeImageView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            self.performSegue(withIdentifier: "showlogin", sender: self)
        })

    }
    
    
    

    
}
