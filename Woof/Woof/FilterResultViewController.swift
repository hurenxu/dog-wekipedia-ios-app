//
//  FilterResultViewController.swift
//  Woof
//
//  Created by Meiyi He on 3/9/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class FilterResultViewController: UIViewController {

    //tags
    var Lexi = ""
    var hair:Int? //default 0. short 1, long 2
    var size:Int? //default 0. small 1, medium 2, large 3
    var group:Int? //default 0. Herding 1; Hound 2; Non-sporting 3; Sporting 4; Terrier 5; Toy 6; Working 7
    var train:Int? //default 0. easy 1; aveg 2; moderately easy 3
    var bark:Int? //default 0. frequent 1; occasional 2; rare s
    
    var groom:Int? //default 0; "High" 1; "Moderate" 2; "Low" 3
    var shed:Int?  //default 0; minimal 1; moderate 2; constant 3; seasonal 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let button = UIButton()
        button.frame = (frame: CGRect(x: self.view.frame.size.width - 60, y: 20, width: 100, height: 50))
        button.backgroundColor = UIColor.red
        button.setTitle("Name your Button ", for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        print(Lexi)
        self.view.addSubview(button)
        print("hair is\(hair)")

        // Do any additional setup after loading the view.
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

