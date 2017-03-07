//
//  FirstViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pulsing animation for login image tapped
        
        avatarImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomepageViewController.addPulse))
        tapGestureRecognizer.numberOfTapsRequired = 1
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    func addPulse(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 100, position: avatarImageView.center)
        pulse.animationDuration = 0.9
        pulse.backgroundColor = UIColor.white.cgColor
        
        self.view.layer.insertSublayer(pulse, below: avatarImageView.layer)
        self.performSegue(withIdentifier: "login", sender: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

