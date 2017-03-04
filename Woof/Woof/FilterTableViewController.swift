//
//  FilterTableViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17  Updated by Ye Zhao 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

//Group :"Herding"; "Hound"; "Non-sporting"; "Sporting"; "Terrier"; "Toy"; "Working"
//Body size :"Large" ; "Medium" ; "Small"
//Hair length :"Long"; "Short"
//Trainability: "Bright"; "Average"; "Fair"
//Energy Level: "Active"; "Chill"
    
//Noteworthy Light 17.0
    
class FilterTableViewController: UIViewController {
    var hair=0; //default 0. short 1, long 2
    var size=0; //default 0. small 1, medium 2, large 3
    var group=0; //default 0. Herding 1; Hound 2; Non-sporting 3; Sporting 4; Terrier 5; Toy 6; Working 7
    var train=0; //default 0. bright 1; aveg 2; fair 3
    var energy=0; //default 0. active 1; chill 2
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let long_hair = UIButton(frame:CGRect(x:10, y:10, width:50, height:25))
        long_hair.backgroundColor = UIColor(red: 253/255,green: 127/255,blue:124/255,alpha:1)
        long_hair.setTitle("Long Hair", for:.normal)
        long_hair.titleLabel?.font = UIFont.init(name :"Noteworthy", size: 17.0)
        long_hair.addTarget(self, action: #selector(LHAction), for: .touchUpInside)
        
        let short_hair = UIButton(frame:CGRect(x:10, y:45, width:50, height:25))
        short_hair.backgroundColor = UIColor(red: 253/255,green: 127/255,blue:124/255,alpha:1)
        short_hair.setTitle("Long Hair", for:.normal)
        short_hair.titleLabel?.font = UIFont.init(name :"Noteworthy", size: 17.0)
        short_hair.addTarget(self, action: #selector(SHAction), for: .touchUpInside)
        
        let small = UIButton(frame:CGRect(x:70, y:10, width:50, height:25))
        small.backgroundColor = UIColor(red: 253/255,green: 127/255,blue:124/255,alpha:1)
        small.setTitle("Long Hair", for:.normal)
        small.titleLabel?.font = UIFont.init(name :"Noteworthy", size: 17.0)
        small.addTarget(self, action: #selector(SAction), for: .touchUpInside)

        let large = UIButton(frame:CGRect(x:70, y:45, width:50, height:25))
        large.backgroundColor = UIColor(red: 253/255,green: 127/255,blue:124/255,alpha:1)
        large.setTitle("Long Hair", for:.normal)
        large.titleLabel?.font = UIFont.init(name :"Noteworthy", size: 17.0)
        large.addTarget(self, action: #selector(LAction), for: .touchUpInside)
        
        let medium = UIButton(frame:CGRect(x:70, y:80, width:50, height:25))
        medium.backgroundColor = UIColor(red: 253/255,green: 127/255,blue:124/255,alpha:1)
        medium.setTitle("Long Hair", for:.normal)
        medium.titleLabel?.font = UIFont.init(name :"Noteworthy", size: 17.0)
        medium.addTarget(self, action: #selector(MAction), for: .touchUpInside)

        
        self.view.addSubview (long_hair)
        self.view.addSubview (short_hair)
        self.view.addSubview (large)
        self.view.addSubview (small)
        self.view.addSubview (medium)
        
        
    }
    @IBAction func SHAction(sender: UIButton!){
        print("Short hair")
        hair=1
    }
    @IBAction func LHAction(sender: UIButton!){
        print("Long hair")
        hair=2
    }
    @IBAction func SAction(sender: UIButton!){
        print("Small")
        size=1
    }
    @IBAction func MAction(sender: UIButton!){
        print("Medium")
        size=2
    }
    @IBAction func LAction(sender: UIButton!){
        print("Large")
        size=3
    }

}
