//
//  ResultViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 3/4/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    var suggestionVC: SuggestionViewController? = nil
    
    // data
    var breedArray: [Breed]! = [Breed]()
    var localUIImage: [UIImage] = [UIImage]()
    var likeBreeds: [Int] = [Int]()
    var nextBreeds: [Int] = [Int]()
    
    // scroll view
    var scrollView: UIScrollView! = nil
    
    // math constants
    let HALF = 2
    
    // offsets
    let TOP_OFFSET = 20
    let TABLE_OFFSET = 70
    let NEXT_TITLE_OFFSET = 210
    let BUTTON_OFFSET = 120
    let SCROLL_OFFSET = 65
    
    // the radius of the corner
    let CORNER_RADIUS = 20
    
    // the labels
    let TITLE_SIZE: CGSize = CGSize(width: 330, height: 60)
    let TITLE_FONT_SIZE: Int = 30
    let FONT = "Noteworthy"
    let TITLE_COLOR: UIColor = UIColor(red: 122.0/255.0, green: 215.0/255.0, blue: 253.0/255.0, alpha: 0.9)
    var likeTitleLabel: UILabel! = nil
    var nextTitleLabel: UILabel! = nil
    
    // the tables
    let TABLE_SIZE: CGSize = CGSize(width: 330, height: 200)
    let TABLE_COLOR: UIColor = UIColor.white
    let CELL_HEIGHT: Int! = 200
    var likeTable: UITableView! = nil
    var nextTable: UITableView! = nil
    
    // the button
    let BUTTON_SIZE: CGSize = CGSize(width: 260, height: 70)
    let BUTTON_FONT_SIZE: Int = 40
    let BUTTON_COLOR: UIColor = UIColor(red: 111.0/255.0, green: 135.0/255.0, blue: 143.0/255.0, alpha: 0.9)
    var restartButton: UIButton! = nil
    
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
    
    func setUpTable(myColor: UIColor, myTable: UITableView) {
        
        myTable.backgroundColor = myColor
        myTable.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myTable.rowHeight = CGFloat(CELL_HEIGHT)
        myTable.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
        scrollView.addSubview(myTable)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row: Int = indexPath.row
        
        var currentBreed: Breed! = nil
        let myCell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as! BreedTableViewCell
        
        var currentImage: UIImage! = nil
        
        // pick a breed
        if tableView == likeTable {
            
            currentBreed = breedArray[likeBreeds[row]]
            currentImage = localUIImage[likeBreeds[row]]
        }
        
        else {
            
            currentBreed = breedArray[nextBreeds[row]]
            currentImage = localUIImage[nextBreeds[row]]
        }

        myCell.labelString = currentBreed.getBreedName()
        myCell.myImage.image = currentImage
        myCell.descriptionString = "Elohim, Essaim... \nElohim, Essaim... \nWare wa motome uttaetari"
        
        return myCell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == likeTable {
            
            return likeBreeds.count
        }
        
        else {
            
            return nextBreeds.count
        }
    }
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        print("nohighlight \(indexPath.row)")
        
        // go to wiki page
        
        if tableView == likeTable {
            
            // switch
        }
        
        else {
            
            // switch
        }
        
        return false
    }
    
    func restartPressed(sender: UIButton!) {
        
        print("switch to suggestion page")
        
        
        while navigationController?.viewControllers.count != 1 {
            
            navigationController?.viewControllers.remove(at: 0)
        }
        
        self.performSegue(withIdentifier: "BackToSuggestionSegue", sender: sender)
    }
    
    // segue to switch to result page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Prepare for Suggestion Segue")
        
        if segue.identifier == "BackToSuggestionSegue" {
            
            let suggestionVC = segue.destination as! SuggestionViewController
            
            //segue.
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("i'm result")
        
        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        self.view.addSubview(scrollView)
        
        let LIKE_TITLE_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(TITLE_SIZE.width) / HALF, y: TOP_OFFSET)
        let LIKE_TABLE_ORIGIN = CGPoint(x: LIKE_TITLE_ORIGIN.x, y: LIKE_TITLE_ORIGIN.y + CGFloat(TABLE_OFFSET))
        let NEXT_TITLE_ORIGIN = CGPoint(x: LIKE_TITLE_ORIGIN.x, y: LIKE_TABLE_ORIGIN.y + CGFloat(NEXT_TITLE_OFFSET))
        let NEXT_TABLE_ORIGIN = CGPoint(x: NEXT_TITLE_ORIGIN.x, y: NEXT_TITLE_ORIGIN.y + CGFloat(TABLE_OFFSET))
        
        likeTitleLabel = UILabel(frame: CGRect(origin: LIKE_TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Breeds That You Liked", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: likeTitleLabel, myColor: TITLE_COLOR)
        
        likeTable = UITableView(frame: CGRect(origin: LIKE_TABLE_ORIGIN, size: TABLE_SIZE))
        setUpTable(myColor: TABLE_COLOR, myTable: likeTable)
        likeTable.delegate = self
        likeTable.dataSource = self
        
        nextTitleLabel = UILabel(frame: CGRect(origin: NEXT_TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Breeds That You Skipped", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: nextTitleLabel, myColor: TITLE_COLOR)
    
        nextTable = UITableView(frame: CGRect(origin: NEXT_TABLE_ORIGIN, size: TABLE_SIZE))
        setUpTable(myColor: TABLE_COLOR, myTable: nextTable)
        nextTable.delegate = self
        nextTable.dataSource = self
        
        // the restart page button
        let RESTART_ORIGIN: CGPoint = CGPoint(x: nextTable.center.x - BUTTON_SIZE.width / CGFloat(HALF), y: nextTable.center.y + CGFloat(BUTTON_OFFSET))
        restartButton = UIButton(frame: CGRect(origin: RESTART_ORIGIN, size: BUTTON_SIZE))
        setUpButtons(myLabel: "New Survey", myFontSize: BUTTON_FONT_SIZE, myButton: restartButton)
        restartButton.addTarget(self, action: #selector(self.restartPressed(sender:)), for: UIControlEvents.touchDown)
        
        scrollView.contentSize.height = restartButton.center.y + CGFloat(SCROLL_OFFSET)
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
