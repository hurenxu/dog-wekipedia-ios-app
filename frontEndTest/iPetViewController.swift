//
//  iPetViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/16/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class iPetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //view.backgroundColor = UIColor.black
        self.title = "iPet"
        print("iPet Page loaded")
        
        
        let userImg = profileImg(name: "BlackEmptyDog")
        
        self.view.addSubview(userImg)
        ImageViewConstraints(Img: userImg)
        
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 250))
        label.center = CGPoint(x: 180, y: 250)
        label.textAlignment = .center
        label.text = "Profile"
        
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        view.addSubview(label)
        
        
    }
    
    func profileImg(name:String) -> UIImageView{
        let Img = UIImageView()
        
        if(name == ""){
            Img.image = UIImage(named:"Yorkshire")
        }else{
            Img.image = UIImage(named:name)
        }
        
        Img.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        Img.translatesAutoresizingMaskIntoConstraints = false
        //You need to call this property so the image is added to your view
        return Img
    }
    
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 30.0).isActive = true
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "iPet", image: UIImage(named: "iPet"), tag: 1)
        tabBarItem.badgeValue = "3"
    }

}
