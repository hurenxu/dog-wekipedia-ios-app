//
//  StatsViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 3/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // math constants
    let HALF: Int = 2
    let CORNOR_RADIUS: Int = 10
    
    var topFilters: [String] = [String]()
    var likeFilters = [String: Int]()
    
    // offsets
    let TOP_OFFSET = 50
    let TOP_BAR_OFFSET = 120
    let BAR_OFFSET = 100
    let LABEL_OFFSET = 60
    let TOP_FILTER_OFFSET = 30
    let FILTER_OFFSET = 50
    
    // the bar stats
    let BAR_SIZE: CGSize = CGSize(width: 330, height: 2)
    var firstBar: UIProgressView! = nil
    var secondBar: UIProgressView! = nil
    var thirdBar: UIProgressView! = nil
    
    // the bar labels
    let LABEL_SIZE: CGSize = CGSize(width: 300, height: 30)
    let TITLE_SIZE: CGSize = CGSize(width: 330, height: 40)
    let TITLE_FONT_SIZE: Int = 40
    let LABEL_FONT_SIZE: Int = 30
    let FONT = "Noteworthy"
    var firstLabel: UILabel! = nil
    var secondLabel: UILabel! = nil
    var thirdLabel: UILabel! = nil
    var titleLabel: UILabel! = nil
    
    let BUTTON_SIZE: CGSize = CGSize(width: 100, height: 40)
    let BUTTON_FONT_SIZE: Int = 20
    
    // function to set up the common specs of bars
    func setUpStatsBar(myBar: UIProgressView) {
        
        myBar.transform = myBar.transform.scaledBy(x: 1, y: 20)
        myBar.tintColor = UIColor.white
        myBar.trackTintColor = UIColor.white.withAlphaComponent(0.4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sample filters
        topFilters.append("First")
        topFilters.append("Second")
        topFilters.append("Third")
        
        likeFilters["First"] = 5
        likeFilters["Second"] = 10
        likeFilters["Third"] = 3
        
        likeFilters["Fourth"] = 4
        likeFilters["Fifth"] = 5
        
        var tempInt: Int = likeFilters["First"]!
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        
        let TITLE_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(TITLE_SIZE.width) / HALF, y: TOP_OFFSET)
        let FIRST_BAR_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(BAR_SIZE.width) / HALF, y: Int(TITLE_ORIGIN.y) + TOP_BAR_OFFSET)
        let FIRST_LABEL_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: FIRST_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let SECOND_BAR_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: FIRST_BAR_ORIGIN.y + CGFloat(BAR_OFFSET))
        let SECOND_LABEL_ORIGIN = CGPoint(x: SECOND_BAR_ORIGIN.x, y: SECOND_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let THIRD_BAR_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: SECOND_BAR_ORIGIN.y + CGFloat(BAR_OFFSET))
        let THIRD_LABEL_ORIGIN = CGPoint(x: THIRD_BAR_ORIGIN.x, y: THIRD_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        
        titleLabel = UILabel(frame: CGRect(origin: TITLE_ORIGIN, size: TITLE_SIZE))
        titleLabel.text = "Filters Statistics"
        
        titleLabel.font = UIFont(name: FONT, size: CGFloat(TITLE_FONT_SIZE))
        titleLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(titleLabel)
        
        firstBar = UIProgressView(frame: CGRect(origin: FIRST_BAR_ORIGIN, size: BAR_SIZE))
        firstBar.progress = Float(Double(tempInt) / 10.0)
        setUpStatsBar(myBar: firstBar)
        self.view.addSubview(firstBar)
        
        firstLabel = UILabel(frame: CGRect(origin: FIRST_LABEL_ORIGIN, size: LABEL_SIZE))
        firstLabel.text = topFilters[0]
        firstLabel.font = UIFont(name: FONT, size: CGFloat(LABEL_FONT_SIZE))
        self.view.addSubview(firstLabel)
        
        secondBar = UIProgressView(frame: CGRect(origin: SECOND_BAR_ORIGIN, size: BAR_SIZE))
        tempInt = likeFilters["Second"]!
        secondBar.progress = Float(Double(tempInt) / 10.0)
        setUpStatsBar(myBar: secondBar)
        self.view.addSubview(secondBar)
        
        secondLabel = UILabel(frame: CGRect(origin: SECOND_LABEL_ORIGIN, size: LABEL_SIZE))
        secondLabel.text = topFilters[1]
        secondLabel.font = UIFont(name: FONT, size: CGFloat(LABEL_FONT_SIZE))
        self.view.addSubview(secondLabel)
        
        thirdBar = UIProgressView(frame: CGRect(origin: THIRD_BAR_ORIGIN, size: BAR_SIZE))
        tempInt = likeFilters["Third"]!
        thirdBar.progress = Float(Double(tempInt) / 10.0)
        setUpStatsBar(myBar: thirdBar)
        self.view.addSubview(thirdBar)
        
        thirdLabel = UILabel(frame: CGRect(origin: THIRD_LABEL_ORIGIN, size: LABEL_SIZE))
        thirdLabel.text = topFilters[2]
        thirdLabel.font = UIFont(name: FONT, size: CGFloat(LABEL_FONT_SIZE))
        self.view.addSubview(thirdLabel)
        
        var currentButton: UIButton! = nil
        var buttonOrigin: CGPoint! = nil
        
        currentButton = UIButton(frame: CGRect(origin: CGPoint(x: thirdBar.frame.origin.x, y: thirdBar.frame.origin.y + CGFloat(FILTER_OFFSET / HALF)), size: BUTTON_SIZE))
        
        for keyAndValuePair in likeFilters {
            
            if !topFilters.contains(keyAndValuePair.key) {
                
                print(keyAndValuePair.key)
                
                // add button
                buttonOrigin = CGPoint(x: currentButton.frame.origin.x, y: currentButton.frame.origin.y + CGFloat(FILTER_OFFSET))
                currentButton = UIButton(frame: CGRect(origin: buttonOrigin, size: BUTTON_SIZE))
                currentButton.setTitle(keyAndValuePair.key, for: UIControlState.normal)
                currentButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                currentButton.titleLabel?.font = UIFont(name: FONT, size: CGFloat(BUTTON_FONT_SIZE))
                currentButton.backgroundColor = UIColor(red: 100.0/255.0, green: 120.0/255.0, blue: 150.0/255.0, alpha: 0.9)
                currentButton.isUserInteractionEnabled = true
                currentButton.layer.cornerRadius = CGFloat(CORNOR_RADIUS)
                self.view.addSubview(currentButton)
            }
        }
        
        
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
