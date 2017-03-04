//
//  ResultViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 3/4/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // data
    var breedArray: [Breed] = [Breed]()
    var likeBreeds: [Int] = [Int]()
    var nextBreeds: [Int] = [Int]()
    
    // scroll view
    var scrollView: UIScrollView! = nil
    
    // math constants
    let HALF = 2
    
    // offsets
    let TOP_OFFSET = 50
    let NEXT_TITLE_OFFSET = 200
    
    // the radius of the corner
    let CORNER_RADIUS = 20
    
    // the labels
    let TITLE_SIZE: CGSize = CGSize(width: 320, height: 80)
    let TITLE_FONT_SIZE: Int = 30
    let FONT = "Noteworthy"
    let TITLE_COLOR: UIColor = UIColor(red: 122.0/255.0, green: 215.0/255.0, blue: 253.0/255.0, alpha: 0.9)
    var likeTitleLabel: UILabel! = nil
    var nextTitleLabel: UILabel! = nil
    
    var likeTable: UITableView! = nil
    var nextTable: UITableView! = nil
    
    // function to set up the common specs of labels
    func setUpLabel(myText: String, myFont: String, myFontSize: Int, myAlignment: NSTextAlignment, myLabel: UILabel, myColor: UIColor) {
        
        myLabel.text = myText
        myLabel.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myLabel.textAlignment = myAlignment
        myLabel.backgroundColor = myColor
        myLabel.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myLabel.clipsToBounds = true
        scrollView.addSubview(myLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("i'm result")
        
        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        self.view.addSubview(scrollView)
        
        let LIKE_TITLE_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(TITLE_SIZE.width) / HALF, y: TOP_OFFSET)
        let NEXT_TITLE_ORIGIN = CGPoint(x: LIKE_TITLE_ORIGIN.x, y: LIKE_TITLE_ORIGIN.y + CGFloat(NEXT_TITLE_OFFSET))
        
        likeTitleLabel = UILabel(frame: CGRect(origin: LIKE_TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Breeds That You Liked", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: likeTitleLabel, myColor: TITLE_COLOR)
        
        nextTitleLabel = UILabel(frame: CGRect(origin: NEXT_TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Breeds That You Skipped", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: nextTitleLabel, myColor: TITLE_COLOR)
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
