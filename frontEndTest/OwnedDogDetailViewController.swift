//
//  OwnedDogDetailViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/28/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class OwnedDogDetailViewController: UIViewController {
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        print(name)
        // Do any additional setup after loading the view.
        
        self.title = "My Dog"
        
        
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 200))
        label.center = CGPoint(x: 180, y: 250)
        label.textAlignment = .center
        
        label.text = name
        label.textColor = UIColor.black
        label.font = label.font.withSize(50)
        view.addSubview(label)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
