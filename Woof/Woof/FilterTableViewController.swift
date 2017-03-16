//
//  FilterTableViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17  Updated by Ye Zhao 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

//Group :"Herding"; "Hound"; "Non-sporting"; "Sporting"; "Terrier"; "Toy"; "Working"
//Body size :"Large" ; "Medium" ; "Small"
//Hair length :"Long"; "Short"
//Trainability: "Bright"; "Average"; "Fair"
//Energy Level: "Active"; "Chill"

//Noteworthy Light 17.0


class FilterTableViewController: UIViewController, UINavigationBarDelegate{
    //var hair=0 //default 0. short 1, long 2
    var size=0 //default 0. small 1, medium 2, large 3
    //var sizeA = {0}
    var group=0 //default 0. Herding 1; Hound 2; Non-sporting 3; Sporting 4; Terrier 5; Toy 6; Working 7
    var train=0 //default 0. easy 1; difficult 2; fair 3
    var bark=0 //default 0. frequent 1; occasional 2; rare 3
    
    var groom = 0 //default 0; "High" 1; "Moderate" 2; "Low" 3
    var shed = 0 //default 0; minimal 1; moderate 2; constant 3; seasonal 4
    
    let CORNER_RADIUS: Int = 10
    var scrollView: UIScrollView! = nil
    let SCROLL_OFFSET = 60
    var noLogInFilters = [String]()
    
    //buttons:
    var button: UIButton! = nil
    var save: UIButton! = nil
    var label: UILabel! = nil
    //var hair_buttons = [ "Short hair", "Long hair"]
    var body_buttons = ["Small", "Medium", "Large"]
    var group_buttons = ["Herding", "Hound", "Working", "Sporting", "Terrier", "Toy", "Non-sporting"]
    var train_buttons = ["Easy", "Difficult", "Fair"]
    var bark_buttons = ["Frequent", "Occasional","Rare"]
    var groom_buttons = ["High","Average","Low"]
    var shedding_buttons = ["Minimal", "Moderate", "Constant", "Seasonal"]
    
    var color = 0 //default 0 black 1; white 2; chocolate 3; golden 4; gray 5
    //"Black" 1; "White" 2; "Red" 3; "Tan" 4; "Silver" 5;"Chocolate" 6; "Yellow" 7; "Seal" 8; "Buff" 9
    //"Golden" 10; "Brindle" 11; "Fawn" 12; "Beige" 13; "Blue" 14;
    //"Apricot" 15; "Brown" 16; "Cream" 17; "Gray" 18; "Mahogany" 19; "Rust" 20; "Liver" 21; "Loan" 22
    //"Agouti" 23; "Sable" 24; "Mantle" 25; "Merle" 26; "Harlequin" 27; "Salt" 28; "Pepper" 29; "Blenheim" 30; "Ruby" 31; "Orange" 32
    
    //var containerView = UIView()
    
    //offsets
    var line_offset = 80
    var button_offset = 0
    let BUTTON_OFFSET = 100
    let LINE_OFFSET = 95
    let LINE_OFFSET_SMALL = 38
    
    
    let label_size_origin = CGPoint(x:20, y:30)
    let label_size_size = CGSize(width: 320, height: 30)
    
    let label_train_origin = CGPoint(x:20, y:125)
    let label_train_size = CGSize(width: 320, height: 30)
    
    let label_bark_origin = CGPoint(x:20, y:220)
    let label_bark_size = CGSize(width: 320, height: 30)
    
    let label_groom_origin = CGPoint(x:20, y:315)
    let label_groom_size = CGSize(width: 320, height: 30)
    
    let label_shed_origin = CGPoint(x:20, y:410)
    let label_shed_size = CGSize(width: 320, height: 30)
    
    let label_group_origin = CGPoint(x:20, y:543)
    let label_group_size = CGSize(width: 320, height: 30)
    let label_end_origin = CGPoint(x:20, y:770)
    
    //size
    let screen_size: CGRect = UIScreen.main.bounds
    
    let font = "Rubik"
    let font_large = "Rubik-Medium"
    //origins
    let top_origin = CGPoint(x: 40, y: 80)
    let next_origin = CGPoint(x: 20, y: 725)
    
    let button_size: CGSize = CGSize(width: 80, height: 30)
    let large_button_size: CGSize = CGSize(width: 120, height: 30)
    let save_button_size: CGSize = CGSize(width: 320, height: 30)
    
    
    let button_font_size: Int = 15
    let save_button_font_size: Int = 18
    let TITLE_FONT_SIZE: Int = 16
    
    
    
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    let green_Full: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white_half: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
    let green_half: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.8)
    let transparent: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0)
    
    
    @IBOutlet weak var background: UIScrollView!
    @IBOutlet weak var foreground: UIScrollView!
    
    var buttonsReference: [UIButton] = [UIButton]()
    
    var filtersString = [String]()
    let filtersDictionary: [String: String] = [
        
        "Large": "Size3",
        "Small": "Size1",
        "Medium": "Size2",
        
        "Herding":"Group1",
        "Hound":"Group2",
        "Working":"Group3",
        "Sporting":"Group4",
        "Terrier":"Group5",
        "Toy":"Group6",
        "Non-sporting":"Group7",
        
        "Easy":"Trainability1",
        "Difficult":"Trainability2",
        "Fair":"Trainability3",
        
        "High": "Grooming1",
        "Average": "Grooming2",
        "Low": "Grooming3",
        
        "Frequent": "Barking1",
        "Occasional": "Barking2",
        "Rare": "Barking3",
        
        "Minimal": "Shedding1",
        "Moderate": "Shedding2",
        "Constant": "Shedding3",
        "Seasonal": "Shedding4"
    ]
    var typeDictionary: [String: Int] = [
        
        "Size": 0,
        "Grooming": 0,
        "Shedding": 0,
        "Group": 0,
        "Barking Level": 0,
        "Trainability": 0
    ]
    
    var typeSizeDictionary: [String: Int]! = [
        
        "Size": 0,
        "Grooming": 0,
        "Shedding": 0,
        "Group": 0,
        "Barking": 0,
        "Trainability": 0
    ]
    
    func setButton(myButton: UIButton!) {
        
        let buttonLabel: String = myButton.titleLabel!.text!
        
        if myButton.backgroundColor != yellow {
            
            print("store \(buttonLabel)")
            
            if !filtersString.contains(buttonLabel) {
                
                filtersString.append(buttonLabel)
            }
            
            let typeWithNum: String! = filtersDictionary[buttonLabel]!
            let end = typeWithNum.index(before: typeWithNum.endIndex)
            let type = typeWithNum.substring(to: end)
            if Functionalities.myUser == nil {
                noLogInFilters.append("\(type): \(myButton.titleLabel!.text!)")
                myButton.backgroundColor = yellow

            } else {
                Functionalities.myUser?.addFavoriteCategoryFilter(filter: "\(type): \(myButton.titleLabel!.text!)")

                myButton.backgroundColor = yellow
            }
        }
            
        else {
            
            print("remove \(buttonLabel)")
            
            let typeWithNum: String = filtersDictionary[buttonLabel]!
            let end = typeWithNum.index(before: typeWithNum.endIndex)
            let type = typeWithNum.substring(to: end)
            if Functionalities.myUser == nil {
                noLogInFilters.append("\(type): \(myButton.titleLabel!.text!)")
                filtersString.remove(at: filtersString.index(of: buttonLabel)!)
                myButton.backgroundColor = white_half
                
            } else {

                Functionalities.myUser?.removeFavoriteCategoryFilter(filter: (filter: "\(type): \(myButton.titleLabel!.text!)"))
            
                filtersString.remove(at: filtersString.index(of: buttonLabel)!)
                myButton.backgroundColor = white_half
            }
        }
    }
    
    // filters are added, implement to remove?
    func filterPressed(sender: UIButton!) {
        
        setButton(myButton: sender)
        
        //if Functionalities.myUser?.userExist(){
        //var select = false
        
        
        /*}else{
         //var select = false
         let buttonLabel: String = sender.titleLabel!.text!
         if sender.backgroundColor != yellow {
         print("store \(buttonLabel)")
         Functionalities.myUser?.addFavoriteCategoryFilter(filter: (sender.titleLabel?.text!)!)
         filtersString.append(buttonLabel)
         sender.backgroundColor = yellow
         }else {
         print("remove \(buttonLabel)")
         Functionalities.myUser?.removeFavoriteCategoryFilter(filter: (sender.titleLabel?.text!)!)
         filtersString.remove(at: filtersString.index(of: buttonLabel)!)
         sender.backgroundColor = white_half
         }
         }    */
    }
    
    // function to set up the common specs of buttons
    func setUpButtons(myLabel: String, myFontSize: Int, myButton: UIButton) {
        
        myButton.setTitle(myLabel, for: UIControlState.normal)
        myButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont(name: font, size: CGFloat(myFontSize))
        myButton.backgroundColor = white_half
        myButton.isUserInteractionEnabled = true
        myButton.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        
        scrollView.addSubview(myButton)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentFavFilters: [String] = [""]
        if Functionalities.myUser == nil {
            currentFavFilters = noLogInFilters
            
        } else {

            currentFavFilters = (Functionalities.myUser?.favoriteCategoryFilters)!
        }
        
        self.title = "Filter"
        self.tabBarItem.title = "Filter"
        
        /**
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:58)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Filter"
         
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        self.view.addSubview(navigationBar)*/
        
        
        //self.title = "Filter"
        //scrolling
        scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height-CGFloat(38)))
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge-shade.jpg")!)
        
        //start adding labels
        label = UILabel(frame: CGRect(origin: label_size_origin, size: label_size_size))
        setUpLabel(myText: "Sizes", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: green_half)
        
        label = UILabel(frame: CGRect(origin: label_train_origin, size: label_train_size))
        setUpLabel(myText: "Trainability", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: green_half)
        
        label = UILabel(frame: CGRect(origin: label_bark_origin, size: label_bark_size))
        setUpLabel(myText: "Barking Level", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: green_half)
        
        label = UILabel(frame: CGRect(origin: label_groom_origin, size: label_groom_size))
        setUpLabel(myText: "Hair Maintain", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: green_half)
        
        label = UILabel(frame: CGRect(origin: label_shed_origin, size: label_shed_size))
        setUpLabel(myText: "Shedding Frequency", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: green_half)
        
        label = UILabel(frame: CGRect(origin: label_group_origin, size: label_group_size))
        setUpLabel(myText: "Group", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: green_half)
        
        /*
         label = UILabel(frame: CGRect(origin: label_end_origin, size: label_group_size))
         setUpLabel(myText: "??", myFont: font_large, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: label, myColor: pink)
         */
        
        //start adding buttons
        button = UIButton(frame: CGRect(origin: CGPoint(x: top_origin.x, y: top_origin.y), size: button_size))
        var buttonOrigin = CGPoint(x:0,y:0)
        
        button_offset=0
        
        
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = 0
        button.frame.origin.x = top_origin.x
        
        for key in body_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
            }
            /*
             if button.frame.origin.x + CGFloat(button_offset) > (screen_size.size.width - 10){
             line_offset += LINE_OFFSET
             button.frame.origin.x = top_origin.x
             }*/
            // add button
            button.frame.origin.x += CGFloat(button_offset)
            
            buttonOrigin = CGPoint(x: button.frame.origin.x , y: top_origin.y + CGFloat(line_offset))
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
            
            if currentFavFilters.contains("Size: \(key)") {
                
                setButton(myButton: button)
            }
        }
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = LINE_OFFSET
        button.frame.origin.x = top_origin.x
        
        for key in train_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
            }
            /*
             if button.frame.origin.x + 2*CGFloat(button_offset) > (screen_size.size.width - 10){
             line_offset += LINE_OFFSET_SMALL
             button_offset=0
             }*/
            // add button
            button.frame.origin.x += CGFloat(button_offset)
            
            buttonOrigin = CGPoint(x: button.frame.origin.x, y: top_origin.y + CGFloat(line_offset))
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
            
            if currentFavFilters.contains("Trainability: \(key)") {
                
                setButton(myButton: button)
            }
        }
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = LINE_OFFSET*2
        button.frame.origin.x = top_origin.x
        
        for key in bark_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
            }
            /*
             if button.frame.origin.x + 2*CGFloat(button_offset) > (screen_size.size.width - 10){
             line_offset += LINE_OFFSET_SMALL
             button_offset=0
             }*/
            // add button
            button.frame.origin.x += CGFloat(button_offset)
            
            buttonOrigin = CGPoint(x: button.frame.origin.x, y: top_origin.y + CGFloat(line_offset))
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
            
            if currentFavFilters.contains("Barking Level: \(key)") {
                
                filterPressed(sender: button)
            }
        }
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = LINE_OFFSET*3
        button.frame.origin.x = top_origin.x
        
        for key in groom_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
            }
            /*
             if button.frame.origin.x + 2*CGFloat(button_offset) > (screen_size.size.width - 10){
             line_offset += LINE_OFFSET_SMALL
             button_offset=0
             }*/
            // add button
            button.frame.origin.x += CGFloat(button_offset)
            
            buttonOrigin = CGPoint(x: button.frame.origin.x, y: top_origin.y + CGFloat(line_offset))
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
            
            if currentFavFilters.contains("Grooming: \(key)") {
                
                filterPressed(sender: button)
            }
        }
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = LINE_OFFSET*4
        button.frame.origin.x = top_origin.x
        for key in shedding_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
            }
            
            if button.frame.origin.x + 1.5*CGFloat(button_offset) > (screen_size.size.width - 10){
                line_offset += LINE_OFFSET_SMALL
                button_offset=0
                button.frame.origin.x = top_origin.x
                button.frame.origin.x += CGFloat(button_offset)
                
            }
            // add button
            button.frame.origin.x += CGFloat(button_offset)
            
            buttonOrigin = CGPoint(x: button.frame.origin.x, y: top_origin.y + CGFloat(line_offset))
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
            
            if currentFavFilters.contains("Shedding: \(key)") {
                
                filterPressed(sender: button)
            }
        }
        
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = LINE_OFFSET*5 + LINE_OFFSET_SMALL
        button.frame.origin.x = top_origin.x
        for key in group_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
            }
            
            if button.frame.origin.x + 1.5*CGFloat(button_offset) > (screen_size.size.width - 10){
                line_offset += LINE_OFFSET_SMALL
                button_offset=0
                button.frame.origin.x = top_origin.x
                button.frame.origin.x += CGFloat(button_offset)
                
            }
            // add button
            button.frame.origin.x += CGFloat(button_offset)
            
            buttonOrigin = CGPoint(x: button.frame.origin.x, y: top_origin.y + CGFloat(line_offset))
            if key == "Non-sporting" {
                button = UIButton(frame: CGRect(origin: buttonOrigin, size: large_button_size))
                
            }else{
                button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            }
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
            
            if currentFavFilters.contains("Group: \(key)") {
                
                filterPressed(sender: button)
            }
        }
        
        buttonOrigin = CGPoint(x: next_origin.x, y: next_origin.y)
        save = UIButton(frame: CGRect(origin: buttonOrigin, size: save_button_size))
        //setup save button
        save.setTitle("DONE", for: UIControlState.normal)
        save.setTitleColor(UIColor.black, for: UIControlState.normal)
        save.titleLabel?.font = UIFont(name: "Rubik-Medium", size: CGFloat(save_button_font_size))
        save.backgroundColor = pink
        save.isUserInteractionEnabled = true
        save.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        
        scrollView.addSubview(save)
        
        save.addTarget(self, action: #selector(self.showResult(sender:)), for: .touchUpInside)
        
        /*let end = UIButton(frame: CGRect(origin: label_end_origin, size: save_button_size))
         //setup save button
         end.setTitle("??", for: UIControlState.normal)
         end.setTitleColor(UIColor.black, for: UIControlState.normal)
         
         end.backgroundColor = transparent
         end.isUserInteractionEnabled = false
         end.layer.cornerRadius = CGFloat(CORNER_RADIUS)
         
         scrollView.addSubview(end)*/
        
        
        self.view.addSubview(scrollView)
        scrollView.contentSize.height = button.center.y + CGFloat(SCROLL_OFFSET)
        
        /**
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)*/
        
        
        
    }
    
    func setZero(){
        
        for pair in typeSizeDictionary {
            
            typeSizeDictionary[pair.key] = 0
        }
        
        for pair in typeDictionary {
            
            typeDictionary[pair.key] = 0
        }
    }
    
    func showResult(sender: UIButton!){
        
        self.performSegue(withIdentifier: "ToFilterResultViewSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        print("Prepare for Filter Result Segue")
        
        if segue.identifier == "ToFilterResultViewSegue" {

            let resultVC = segue.destination as! FilterResultViewController
            
            setZero()
            
            for myFilter in filtersString {
                
                let value: String! = filtersDictionary[myFilter]!
                
                let end = value.index(before: value.endIndex)
                
                let filterType = value.substring(to: end)
                let filterNum = Int(value.substring(from: end))

                typeSizeDictionary[filterType]! += 1
                
                if typeDictionary[filterType] != 0 {
                    
                    typeDictionary[filterType] = 100
                }
                    
                else {
                    
                    typeDictionary[filterType] = filterNum
                }
            }
                        
            resultVC.size = typeDictionary["Size"]
            resultVC.groom = typeDictionary["Grooming"]
            resultVC.train = typeDictionary["Trainability"]
            resultVC.bark = typeDictionary["Barking"]
            resultVC.group = typeDictionary["Group"]
            resultVC.shed = typeDictionary["Shedding"]
            
            print("done processing filters")
        }
    }
    
    func goBack(){
        print("call goBack function")
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
