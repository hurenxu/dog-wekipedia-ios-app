//
//  ViewController.swift
//  cellTest
//
//  Created by Meiyi He on 2/11/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // since by default, the tab bar controller will load the first tab, so make tab1 as the home page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.black
        self.title = "HomePage"
        print("item 1 loaded")
        
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 200))
        label.center = CGPoint(x: 180, y: 250)
        label.textAlignment = .center
        label.text = "Woof!"
        label.textColor = UIColor.white
        label.font = label.font.withSize(30)
        view.addSubview(label)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "HomePage", image: UIImage(named: "homeTab"), tag: 1)
    }
}


