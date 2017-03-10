//
//  FilterResultViewController.swift
//  Woof
//
//  Created by Meiyi He on 3/9/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class FilterResultViewController: UIViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource{

    //tags
    var Lexi = ""
    var hair:Int? //default 0. short 1, long 2
    var size:Int? //default 0. small 1, medium 2, large 3
    var group:Int? //default 0. Herding 1; Hound 2; Non-sporting 3; Sporting 4; Terrier 5; Toy 6; Working 7
    var train:Int? //default 0. easy 1; aveg 2; moderately easy 3
    var bark:Int? //default 0. frequent 1; occasional 2; rare s
    
    var groom:Int? //default 0; "High" 1; "Moderate" 2; "Low" 3
    var shed:Int?  //default 0; minimal 1; moderate 2; constant 3; seasonal 4
    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // data
    var breedArray: [Breed]! = [Breed]()
    var breeds: [Int] = [Int]()
    
    // scroll view
    var scrollView: UIScrollView! = nil
    
    
    // origins
    let anounce_origin = CGPoint(x: 10, y: 30)
    let result_origin = CGPoint(x:12, y:100)

    
    // the radius of the corner
    let CORNER_RADIUS = 10
    
    // the labels
    let TITLE_SIZE: CGSize = CGSize(width: 353, height: 40)
    let TITLE_FONT_SIZE: Int = 4
    let FONT = "Rubik_Medium"
    var anounce_label: UILabel! = nil
    
    //colors
    let pale_green: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.5)
    let green_Full: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white_half: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
    
    
    // the tables
    let TABLE_SIZE: CGSize = CGSize(width: 353, height: 600)
    let TABLE_COLOR: UIColor = UIColor.white
    let CELL_HEIGHT: Int! = 80
    var table: UITableView! = nil
    
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
        
        currentBreed = breedArray[breeds[row]]


        // create table cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as! BreedTableViewCell
        
        myCell.labelString = currentBreed.getBreedName()
        myCell.imageString = currentBreed.getImage()
        myCell.descriptionString = "Elohim, Essaim... \nElohim, Essaim... \nWare wa motome uttaetari"
        
        return myCell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        print("nohighlight \(indexPath.row)")
        
        // go to wiki page
        
        if tableView == table {
            
            // switch
        }
            
        else {
            
            // switch
        }
        
        return false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //self.title = "Filter Result"
        
        //self.view.addSubview(backButton)
        
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:64)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Filter Result"
        
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        self.view.addSubview(navigationBar)

        print(Lexi)
        print("hair is\(hair)")

        // Do any additional setup after loading the view.
        
        
        print("i'm result")
        
        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView(frame: CGRect(x:0, y:58, width:self.view.frame.size.width, height:self.view.frame.size.height-CGFloat(64)))
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        self.view.addSubview(scrollView)
        
    
        
        anounce_label = UILabel(frame: CGRect(origin: anounce_origin, size: TITLE_SIZE))
        setUpLabel(myText: "ALL TAGS SAVED Σ(っ°Д°)っ !!!∑(ﾟДﾟノ)ノ", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: anounce_label, myColor: white_half)
        
        table = UITableView(frame: CGRect(origin: result_origin, size: TABLE_SIZE))
        setUpTable(myColor: TABLE_COLOR, myTable: table)
        table.delegate = self
        table.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func goBack(){
        print("call goBack function")
        dismiss(animated: true, completion: nil)
    }

}

