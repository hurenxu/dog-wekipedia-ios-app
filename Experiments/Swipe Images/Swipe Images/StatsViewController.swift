//
//  StatsViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 3/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var sampleString: String = String()
    weak var delegate: SuggestionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.gray
        
        print("sample \(sampleString)")
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
