//
//  LoginViewController.swift
//  Woof
//
//  Created by Joanna Xu on 1/31/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        
        view.addSubview(loginButton)

    }
    

}
