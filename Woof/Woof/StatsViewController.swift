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
    
    var suggestionVC: SuggestionViewController? = nil
    
    // for result page
    var breedArray: [Breed] = [Breed]()
    var likeBreeds: [Int] = [Int]()
    var localUIImage: [UIImage] = [UIImage]()
    var nextBreeds: [Int] = [Int]()
    
    var scrollView: UIScrollView! = nil
    
    // math constants
    let HALF: Int = 2
    let CORNER_RADIUS: Int = 10
    
    var topFilters: [String] = [String]()
    var likeFilters = [String: Int]()
    
    // offsets
    let TOP_OFFSET = 20
    let TOP_BAR_OFFSET = 150
    let BAR_OFFSET = 110
    let LABEL_OFFSET = 70 // up from bar
    let TITLE_FILTER_OFFSET = 120
    let FILTER_OFFSET = 50
    let TOP_BUTTON_OFFSET = 40
    let SCROLL_OFFSET = 80
    
    // the bar stats
    let BAR_SIZE: CGSize = CGSize(width: 330, height: 2)
    var firstBar: UIProgressView! = nil
    var secondBar: UIProgressView! = nil
    var thirdBar: UIProgressView! = nil
    
    // the bar labels
    let LABEL_SIZE: CGSize = CGSize(width: 300, height: 43)
    let TITLE_SIZE: CGSize = CGSize(width: 330, height: 70)
    let TITLE_FONT_SIZE: Int = 22
    let LABEL_FONT_SIZE: Int = 18
    let FONT = "Rubik-Medium"
    var firstLabel: UILabel! = nil
    var secondLabel: UILabel! = nil
    var thirdLabel: UILabel! = nil
    var titleLabel: UILabel! = nil
    var filterTitleLabel: UILabel! = nil
    let LABEL_COLOR: UIColor = UIColor(red: 253.0/255.0, green: 127.0/255.0, blue: 124.0/255.0, alpha: 0.9)
    let TITLE_COLOR: UIColor = UIColor(red: 122.0/255.0, green: 215.0/255.0, blue: 253.0/255.0, alpha: 0.9)
    let NO_FILTER_TEXT = "No Top Filters Available"
    
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    let green_Full: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white_half: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
    let green_half: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    
    
    
    // the buttons
    var currentButton: UIButton! = nil
    var buttonOrigin: CGPoint! = nil
    let BUTTON_SIZE: CGSize = CGSize(width: 250, height: 30)
    let NEXT_BUTTON_SIZE: CGSize = CGSize(width: 100, height: 60)
    let NEXT_BUTTON_FONT_SIZE: Int = 28
    let BUTTON_FONT_SIZE: Int = 15
    var nextButton: UIButton! = nil
    let BUTTON_COLOR: UIColor = UIColor(red: 111.0/255.0, green: 135.0/255.0, blue: 143.0/255.0, alpha: 0.9)
    
    // the user
    // let user: USER! = nil
    
    // function to set up the common specs of bars
    func setUpStatsBar(myValue: Int, myBar: UIProgressView) {
        
        if likeBreeds.count != 0 {
            
            myBar.progress = Float(Double(myValue) / Double(likeBreeds.count))
        }
        
        else {
            
            myBar.progress = 0
        }
        
        myBar.transform = myBar.transform.scaledBy(x: 1, y: 20)
        myBar.tintColor = UIColor.white
        myBar.trackTintColor = UIColor.white.withAlphaComponent(0.4)
        scrollView.addSubview(myBar)
    }
    
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
    
    // function to set up the common specs of buttons
    func setUpButtons(myLabel: String, myFontSize: Int, myButton: UIButton) {
        
        myButton.setTitle(myLabel, for: UIControlState.normal)
        myButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont(name: FONT, size: CGFloat(myFontSize))
        myButton.backgroundColor = BUTTON_COLOR
        myButton.isUserInteractionEnabled = true
        myButton.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        scrollView.addSubview(myButton)
    }
    
    // filters are added, implement to remove?
    func filterPressed(sender: UIButton!) {
        
        let buttonLabel: String = sender.titleLabel!.text!
        
        if sender.backgroundColor == BUTTON_COLOR {
            
            print("store \(buttonLabel)")
            Functionalities.myUser?.addFavoriteCategoryFilter(filter: (sender.titleLabel?.text!)!)
            sender.backgroundColor = yellow
        }
        
        else {
            
            print("remove \(buttonLabel)")
            Functionalities.myUser?.removeFavoriteCategoryFilter(filter: (sender.titleLabel?.text!)!)
            sender.backgroundColor = BUTTON_COLOR
        }
        // user.addFavoriteFilter(\buttonLabel)
    }
    
    func nextPressed(sender: UIButton!) {
        
        print("switch to result page")
        
        self.performSegue(withIdentifier: "ToResultSegue", sender: sender)        
    }
    
    // segue to switch to result page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Prepare for Result Segue")
        
        if segue.identifier == "ToResultSegue" {
            
            let resultVC = segue.destination as! ResultViewController
            
            // pass data to stats page then switch to result page
            resultVC.breedArray = breedArray
            resultVC.likeBreeds = likeBreeds
            resultVC.localUIImage = localUIImage
            resultVC.nextBreeds = nextBreeds
            resultVC.suggestionVC = self.suggestionVC!
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "Statistics"
        
        // initialize user here
        // user = USER(  )
        
        // set up the scroll view
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge-shade.jpg")!)
        self.view.addSubview(scrollView)
        
        // the origin of things
        let TITLE_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(TITLE_SIZE.width) / HALF, y: TOP_OFFSET)
        let FIRST_BAR_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(TITLE_SIZE.width) / HALF, y: Int(TITLE_ORIGIN.y) + TOP_BAR_OFFSET)
        let FIRST_LABEL_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x+20, y: FIRST_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let SECOND_BAR_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: FIRST_BAR_ORIGIN.y + CGFloat(BAR_OFFSET))
        let SECOND_LABEL_ORIGIN = CGPoint(x: SECOND_BAR_ORIGIN.x+20, y: SECOND_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let THIRD_BAR_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: SECOND_BAR_ORIGIN.y + CGFloat(BAR_OFFSET))
        let THIRD_LABEL_ORIGIN = CGPoint(x: THIRD_BAR_ORIGIN.x+20, y: THIRD_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let FILTER_LABEL_ORIGIN = CGPoint(x: TITLE_ORIGIN.x, y: THIRD_LABEL_ORIGIN.y + CGFloat(TITLE_FILTER_OFFSET))
        
        // set up the title
        titleLabel = UILabel(frame: CGRect(origin: TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Most Popular Filters", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: titleLabel, myColor: pink)
        
        // set up the first bar
        firstBar = UIProgressView(frame: CGRect(origin: FIRST_BAR_ORIGIN, size: BAR_SIZE))
        
        // set up the first label
        firstLabel = UILabel(frame: CGRect(origin: FIRST_LABEL_ORIGIN, size: LABEL_SIZE))
        

        // set up the second bar
        secondBar = UIProgressView(frame: CGRect(origin: SECOND_BAR_ORIGIN, size: BAR_SIZE))
        
        // set up the second label
        secondLabel = UILabel(frame: CGRect(origin: SECOND_LABEL_ORIGIN, size: LABEL_SIZE))
        
        // set up the third bar
        thirdBar = UIProgressView(frame: CGRect(origin: THIRD_BAR_ORIGIN, size: BAR_SIZE))
        
        // set up the third label
        thirdLabel = UILabel(frame: CGRect(origin: THIRD_LABEL_ORIGIN, size: LABEL_SIZE))
        
        // set up the filter title label
        filterTitleLabel = UILabel(frame: CGRect(origin: FILTER_LABEL_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Click to Add Filters", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: filterTitleLabel, myColor: pink)
        
        if likeFilters.count != 0 {
            
            setUpStatsBar(myValue: likeFilters[topFilters[0]]!, myBar: firstBar)
            setUpStatsBar(myValue: likeFilters[topFilters[1]]!, myBar: secondBar)
            setUpStatsBar(myValue: likeFilters[topFilters[2]]!, myBar: thirdBar)
            
            setUpLabel(myText: topFilters[0], myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: firstLabel, myColor: green_half)
            setUpLabel(myText: topFilters[1], myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: secondLabel, myColor: green_half)
            setUpLabel(myText: topFilters[2], myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: thirdLabel, myColor: green_half)
        }
            
        else {
            
            setUpStatsBar(myValue: 0, myBar: firstBar)
            setUpStatsBar(myValue: 0, myBar: secondBar)
            setUpStatsBar(myValue: 0, myBar: thirdBar)
            
            setUpLabel(myText: NO_FILTER_TEXT, myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: firstLabel, myColor: LABEL_COLOR)
            setUpLabel(myText: NO_FILTER_TEXT, myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: secondLabel, myColor: LABEL_COLOR)
            setUpLabel(myText: NO_FILTER_TEXT, myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: thirdLabel, myColor: LABEL_COLOR)
        }
        
        // dummy current button reference, set its position
        currentButton = UIButton(frame: CGRect(origin: CGPoint(x: filterTitleLabel.center.x - BUTTON_SIZE.width / CGFloat(HALF), y: filterTitleLabel.frame.origin.y + CGFloat(TOP_BUTTON_OFFSET)), size: CGSize(width: 0, height: 0)))
        
        // iterate through all filters to get all labels
        for keyAndValuePair in likeFilters {
            
            // add button
            buttonOrigin = CGPoint(x: currentButton.frame.origin.x, y: currentButton.frame.origin.y + CGFloat(FILTER_OFFSET))
            currentButton = UIButton(frame: CGRect(origin: buttonOrigin, size: BUTTON_SIZE))
            setUpButtons(myLabel: keyAndValuePair.key, myFontSize: BUTTON_FONT_SIZE, myButton: currentButton)
            currentButton.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
        }
        
        print("in suggestion")
        
        // the next page button
        let NEXT_ORIGIN: CGPoint = CGPoint(x: firstBar.frame.origin.x + BAR_SIZE.width - NEXT_BUTTON_SIZE.width, y: currentButton.center.y + CGFloat(FILTER_OFFSET))
        nextButton = UIButton(frame: CGRect(origin: NEXT_ORIGIN, size: NEXT_BUTTON_SIZE))
        //setUpButtons(myLabel: "Next", myFontSize: NEXT_BUTTON_FONT_SIZE, myButton: nextButton)
        nextButton.setTitle("Next", for: UIControlState.normal)
        nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        nextButton.titleLabel?.font = UIFont(name: FONT, size: CGFloat(NEXT_BUTTON_FONT_SIZE))
        nextButton.backgroundColor = pink
        nextButton.isUserInteractionEnabled = true
        nextButton.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        scrollView.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(self.nextPressed(sender:)), for: UIControlEvents.touchDown)
        
        // adjust the scroll view size

        scrollView.contentSize.height = nextButton.center.y + CGFloat(SCROLL_OFFSET)        
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
