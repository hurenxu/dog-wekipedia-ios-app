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
    let TOP_OFFSET = 50
    let TABLE_OFFSET = 70
    let NEXT_TITLE_OFFSET = 210
    
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
        
        print("stuck?")
        // pick a breed
        if tableView == likeTable {
            
            currentBreed = breedArray[likeBreeds[row]]
            currentImage = localUIImage[likeBreeds[row]]
        }
        
        else {
            
            currentBreed = breedArray[nextBreeds[row]]
            currentImage = localUIImage[nextBreeds[row]]
        }
        
        print("reach here?")
        // create table cell
        //let myCell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as! BreedTableViewCell

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
