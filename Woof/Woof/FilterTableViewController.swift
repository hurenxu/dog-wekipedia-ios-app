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
    var train=0 //default 0. easy 1; aveg 2; moderately easy 3
    var bark=0 //default 0. frequent 1; occasional 2; rare 3
    
    var groom = 0 //default 0; "High" 1; "Moderate" 2; "Low" 3
    var shed = 0 //default 0; minimal 1; moderate 2; constant 3; seasonal 4
    
    let CORNER_RADIUS: Int = 10
    var scrollView: UIScrollView! = nil
    let SCROLL_OFFSET = 80
    
    //buttons:
    var button: UIButton! = nil
    var save: UIButton! = nil
    //var hair_buttons = [ "Short hair", "Long hair"]
    var body_buttons = ["Small", "Medium", "Large"]
    var group_buttons = ["Herding", "Hound", "Working", "Sporting", "Terrier", "Toy", "Non-sporting"]
    var train_buttons = ["Easy", "Difficult", "Fair"]
    var bark_buttons = ["Frequent", "Occasional","Rare"]
    var groom_buttons = ["High","Moderatg","Low"]
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
    
    //size
    let screen_size: CGRect = UIScreen.main.bounds
    
    let font = "Rubik"
    //origins
    let top_origin = CGPoint(x: 40, y: 80)
    let next_origin = CGPoint(x: 250, y: 20)
    
    let button_size: CGSize = CGSize(width: 80, height: 30)
    let large_button_size: CGSize = CGSize(width: 120, height: 30)
    let save_button_size: CGSize = CGSize(width: 100, height: 40)
    
    
    let button_font_size: Int = 15
    let save_button_font_size: Int = 18
    
    
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    let green_Full: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white_half: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
    
    
    @IBOutlet weak var background: UIScrollView!
    @IBOutlet weak var foreground: UIScrollView!
    
    
    
    
    
    var filtersString = [String]()
    let filtersDictionary: [String: String] = [
        
        "Large": "size3",
        "Small": "size1",
        "Medium": "size2",
        
        "Herding":"group1",
        "Hound":"group2",
        "Working":"group3",
        "Sporting":"group4",
        "Terrier":"group5",
        "Toy":"group6",
        "Non-sporting":"group7",
        
        "Easy":"train1",
        "Difficult":"train1",
        "Fair":"train1",
        
        "High": "groom1",
        "Moderatg": "groom2",
        "Low": "groom3",
        
        "Frequent": "bark1",
        "Occasional": "bark2",
        "Rare": "bark3",
        
        "Minimal": "shed1",
        "Moderate": "shed2",
        "Constant": "shed3",
        "Seasonal": "shed4"
    ]
    var typeDictionary: [String: Int] = [
        
        "size": 0,
        "groom": 0,
        "shed": 0,
        "group": 0,
        "bark": 0,
        "train": 0
    ]
    
    var typeSizeDictionary: [String: Int]! = [
        
        "size": 0,
        "groom": 0,
        "shed": 0,
        "group": 0,
        "bark": 0,
        "train": 0
    ]
    
    // filters are added, implement to remove?
    func filterPressed(sender: UIButton!) {
        //var select = false
        
        let buttonLabel: String = sender.titleLabel!.text!
        
        if sender.backgroundColor != yellow {
            
            print("store \(buttonLabel)")
            Functionalities.myUser?.addFavoriteCategoryFilter(filter: (sender.titleLabel?.text!)!)
            filtersString.append(buttonLabel)
            
            sender.backgroundColor = yellow
        }
            
        else {
            
            print("remove \(buttonLabel)")
            Functionalities.myUser?.removeFavoriteCategoryFilter(filter: (sender.titleLabel?.text!)!)
            filtersString.remove(at: filtersString.index(of: buttonLabel)!)
            sender.backgroundColor = white_half
        }
        
        /**
         //sender.isUserInteractionEnabled = false
         //sender.backgroundColor = yellow
         switch (sender.titleLabel!.text){
         /* case "Long hair"?:
         if hair != 0 {
         hair = 100
         }
         hair = 2;
         print ("hair is \(hair)")
         break;
         case "Short hair"?:
         hair = 1;
         if hair != 0 {
         hair = 100
         }
         print ("hair is \(hair)")
         break;*/
         case "Small"?:
         if size == 1 {
         size = 0
         break
         }
         
         if size != 0 {
         size = 100
         break
         }
         size = 1;
         break;
         case "Large"?:
         if size == 3 {
         size = 0
         break
         }
         if size != 0 {
         size = 100
         break
         }
         
         size = 3;
         break;
         case "Medium"?:
         if size == 2 {
         size = 0
         break
         }
         if size != 0 {
         size = 100
         break
         }
         
         size = 2;
         break;
         case "Herding"?:
         if group == 1 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 1;
         break;
         case "Hound"?:
         if group == 2 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 2;
         break;
         case "Non_sporting"?:
         if group == 3 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 3;
         break;
         case "Sporting"?:
         if group == 4 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 4;
         break;
         case "Terrier"?:
         if group == 5 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 5;
         break;
         case "Toy"?:
         if group == 6 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 6;
         break;
         case "Working"?:
         if group == 7 {
         group = 0
         break
         }
         if group != 0 {
         group = 100
         break
         }
         
         group = 7;
         break;
         case "Easy"?:
         if train == 1 {
         train = 0
         break
         }
         if train != 0 {
         train = 100
         break
         }
         
         train = 1;
         break;
         case "Difficult"?:
         if train == 2 {
         train = 0
         break
         }
         
         if train != 0 {
         train = 100
         break
         }
         train = 2;
         break;
         case "Fair"?:
         if train == 3 {
         train = 0
         break
         }
         if train != 0 {
         train = 100
         break
         }
         
         train = 3;
         break;
         case "Frequent"?:
         if bark == 1 {
         bark = 0
         break
         }
         if bark != 0 {
         bark = 100
         break
         }
         
         bark = 1;
         break;
         case "Occasional"?:
         if bark == 2 {
         bark = 0
         break
         }
         if bark != 0 {
         bark = 100
         break
         }
         
         bark = 2;
         break;
         case "Rare"?:
         if bark == 3 {
         bark = 0
         break
         }
         if bark != 0 {
         bark = 100
         break
         }
         
         bark = 3;
         break;
         case "High"?:
         if groom == 1 {
         groom = 0
         break
         }
         if groom != 0 {
         groom = 100
         break
         }
         
         groom = 1;
         break;
         case "Moderate"?:
         if groom == 2 {
         groom = 0
         break
         }
         if groom != 0 {
         groom = 100
         break
         }
         
         groom = 2;
         break;
         case "Low"?:
         if groom == 3 {
         groom = 0
         break
         }
         if groom != 0 {
         groom = 100
         break
         }
         
         
         groom = 3;
         break;
         case "Minimal"?:
         if shed == 1 {
         shed = 0
         break
         }
         if shed != 0 {
         shed = 100
         break
         }
         
         shed = 1;
         break;
         case "Moderate"?:
         if shed == 2 {
         shed = 0
         break
         }
         if shed != 0 {
         shed = 100
         break
         }
         
         shed = 2;
         break;
         case "Constant"?:
         if shed == 3 {
         shed = 0
         break
         }
         if shed != 0 {
         shed = 100
         break
         }
         
         shed = 3;
         break;
         case "Seasonal"?:
         if shed == 4 {
         shed = 0
         break
         }
         if shed != 0 {
         shed = 100
         break
         }
         
         shed = 4;
         break;
         default:
         break;
         
         }*/
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:58)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Filter"
        
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        self.view.addSubview(navigationBar)
        
        
        //self.title = "Filter"
        //scrolling
        scrollView = UIScrollView(frame: CGRect(x:0, y:58, width:self.view.frame.size.width, height:self.view.frame.size.height-CGFloat(58)))
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge-shade.jpg")!)
        
        
        /*let shade = UIImageView(frame:UIScreen.main.bounds)
         shade.backgroundColor = UIColor.black
         shade.alpha = 0.5
         scrollView.addSubview(shade)
         scrollView.sendSubview(toBack: shade)
         
         
         let BackimageView = UIImageView(frame:UIScreen.main.bounds)
         BackimageView.image = UIImage(named:"bacgroundHome.png")
         scrollView.addSubview(BackimageView)
         scrollView.sendSubview(toBack: BackimageView)*/
        //start adding buttons
        button = UIButton(frame: CGRect(origin: CGPoint(x: top_origin.x, y: top_origin.y), size: button_size))
        var buttonOrigin = CGPoint(x:0,y:0)
        
        button_offset=0
        // for looooooooooooop for hair buttons
        /*for key in hair_buttons {
         if buttonOrigin.x != 0 {
         button_offset = BUTTON_OFFSET
         
         
         }
         
         print("x value: \(button.frame.origin.x+CGFloat(button_offset))")
         button.frame.origin.x += CGFloat(button_offset)
         buttonOrigin = CGPoint(x: button.frame.origin.x + CGFloat(button_offset), y: button.frame.origin.y)
         
         button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
         setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
         button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
         }*/
        
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
        }
        
        buttonOrigin = CGPoint(x: next_origin.x, y: next_origin.y)
        save = UIButton(frame: CGRect(origin: buttonOrigin, size: save_button_size))
        //setup save button
        save.setTitle("DONE", for: UIControlState.normal)
        save.setTitleColor(UIColor.black, for: UIControlState.normal)
        save.titleLabel?.font = UIFont(name: "Rubik_Medium", size: CGFloat(save_button_font_size))
        save.backgroundColor = pink
        save.isUserInteractionEnabled = true
        save.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        
        scrollView.addSubview(save)
        
        save.addTarget(self, action: #selector(self.showResult(_:)), for: .touchUpInside)
        
        //save.addTarget(self, action: #selector(self.prepare(_ sender:)), for: UIControlEvents.touchDown)
        
        
        self.view.addSubview(scrollView)
        scrollView.contentSize.height = button.center.y + CGFloat(SCROLL_OFFSET)
        
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        
        
    }
    
    func setZero(){
        
        for pair in typeSizeDictionary {
            
            typeSizeDictionary[pair.key] = 0
        }
        
        for pair in typeDictionary {
            
            typeDictionary[pair.key] = 0
        }
    }
    
    func showResult(_ Sender: UIButton!){
        let secondViewController:FilterResultViewController = FilterResultViewController()
        
        setZero()
        
        for myFilter in filtersString {
            
            let value: String! = filtersDictionary[myFilter]!
            
            let end = value.index(before: value.endIndex)
            
            let filterType = value.substring(to: end)
            let filterNum = Int(value.substring(from: end))
            print("end index \(filterType) & \(filterNum)")
            typeSizeDictionary[filterType]! += 1
            
            if typeDictionary[filterType] != 0 {
                
                typeDictionary[filterType] = 100
            }
                
            else {
                
                typeDictionary[filterType] = filterNum
            }
        }
        
        secondViewController.size = typeDictionary["size"]
        secondViewController.groom = typeDictionary["groom"]
        secondViewController.train = typeDictionary["train"]
        secondViewController.bark = typeDictionary["bark"]
        secondViewController.group = typeDictionary["group"]
        secondViewController.shed = typeDictionary["shed"]
        
        print("done processing filters")
        
        self.present(secondViewController, animated: true, completion: nil)
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        //override func prepare(sender: Any?) {
    //        print("Prepare for Filter Result Segue")
    //        if segue.identifier == "switch" {
    //
    //            print("enter indexpath")
    //            let controller = (segue.destination as! UINavigationController).topViewController as!FilterResultViewController
    //
    //            controller.hair = hair
    //            controller.size = size
    //            controller.groom = groom
    //            controller.train = train
    //            controller.bark = bark
    //            controller.group = group
    //            controller.shed = shed
    //        }
    //    }
    func goBack(){
        print("call goBack function")
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
