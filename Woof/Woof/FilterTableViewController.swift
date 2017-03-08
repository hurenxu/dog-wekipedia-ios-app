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


class FilterTableViewController: UIViewController, UIScrollViewDelegate{
    var hair=0; //default 0. short 1, long 2
    var size=0; //default 0. small 1, medium 2, large 3
    var group=0; //default 0. Herding 1; Hound 2; Non-sporting 3; Sporting 4; Terrier 5; Toy 6; Working 7
    var train=0; //default 0. easy 1; aveg 2; moderately easy 3
    var bark=0; //default 0. frequent 1; occasional 2; rare 3
    
    var groom = 0; //default 0; "High" 1; "Moderate" 2; "Low" 3
    var shed = 0; //default 0; minimal 1; moderate 2; constant 3; seasonal 4
    
    let CORNER_RADIUS: Int = 10
    var scrollView: UIScrollView! = nil
    let SCROLL_OFFSET = 80
    
    //buttons:
    var button: UIButton! = nil
    var hair_buttons = [ "Short hair", "Long hair"]
    var body_buttons = ["Small", "Medium", "Large"]
    var group_buttons = ["Herding", "Hound", "Non-sporting", "Sporting", "Terrier", "Toy", "Working"]
    var train_buttons = ["Easy", "Average", "Fair"]
    var bark_buttons = ["Frequent", "Occasional","Rare"]
    var groom_buttons = ["High","Moderate","Low"]
    var shedding_buttons = ["Minimal", "Moderate", "Constant", "Seasonal"]
    
    var color = 0 //default 0 black 1; white 2; chocolate 3; golden 4; gray 5
    //"Black" 1; "White" 2; "Red" 3; "Tan" 4; "Silver" 5;"Chocolate" 6; "Yellow" 7; "Seal" 8; "Buff" 9
    //"Golden" 10; "Brindle" 11; "Fawn" 12; "Beige" 13; "Blue" 14;
    //"Apricot" 15; "Brown" 16; "Cream" 17; "Gray" 18; "Mahogany" 19; "Rust" 20; "Liver" 21; "Loan" 22
    //"Agouti" 23; "Sable" 24; "Mantle" 25; "Merle" 26; "Harlequin" 27; "Salt" 28; "Pepper" 29; "Blenheim" 30; "Ruby" 31; "Orange" 32
    
    var containerView = UIView()
    
    //offsets
    var line_offset = 80
    var button_offset = 0
    let BUTTON_OFFSET = 100
    let LINE_OFFSET = 95
    let LINE_OFFSET_SMALL = 38
    
    //size
    let screen_size: CGRect = UIScreen.main.bounds
    
    let font = "Noteworthy"
    //origins
    let top_origin = CGPoint(x: 20, y: 80)
    
    let button_size: CGSize = CGSize(width: 80, height: 30)
    
    let button_font_size: Int = 15
    
    
    let pale_green: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.5)
    let green_Full: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white_half: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
    
    
    @IBOutlet weak var background: UIScrollView!
    @IBOutlet weak var foreground: UIScrollView!
    
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
    
    // filters are added, implement to remove?
    func filterPressed(sender: UIButton!) {
        
        let buttonLabel: String = sender.titleLabel!.text!
        
        print("store \(buttonLabel)")
        
        sender.isUserInteractionEnabled = false
        sender.backgroundColor = pink
        switch (sender.titleLabel!.text){
        case "Long hair"?:
            hair = 2;
            print ("hair is \(hair)")
            break;
        case "Short hair"?:
            hair = 1;
            break;
        case "Small"?:
            size = 1;
            break;
        case "Large"?:
            size = 3;
            break;
        case "Medium"?:
            size = 2;
            break;
        case "Herding"?:
            group = 1;
            break;
        case "Hound"?:
            group = 2;
            break;
        case "Non_sporting"?:
            group = 3;
            break;
        case "Sporting"?:
            group = 4;
            break;
        case "Terrier"?:
            group = 5;
            break;
        case "Toy"?:
            group = 6;
            break;
        case "Working"?:
            group = 7;
            break;
        case "Easy"?:
            train = 1;
            break;
        case "Average"?:
            train=2;
            break;
        case "Fair"?:
            train=3;
            break;
        case "Frequent"?:
            bark=1;
            break;
        case "Occasional"?:
            bark=2;
            break;
        case "Rare"?:
            bark=3;
            break;
        case "High"?:
            groom=1;
            break;
        case "Occasional"?:
            groom=2;
            break;
        case "Low"?:
            groom=3;
            break;
        case "Minimal"?:
            shed=1;
            break;
        case "Moderate"?:
            shed=2;
            break;
        case "Constant"?:
            shed=3;
            break;
        case "Seasonal"?:
            shed=4;
            break;
        default:
            break;
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrolling
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        
        //start adding buttons
        button = UIButton(frame: CGRect(origin: CGPoint(x: top_origin.x, y: top_origin.y), size: button_size))
        var buttonOrigin = CGPoint(x:0,y:0)
        
        button_offset=0
        // for looooooooooooop for hair buttons
        for key in hair_buttons {
            if buttonOrigin.x != 0 {
                button_offset = BUTTON_OFFSET
                
                
            }
            
            print("x value: \(button.frame.origin.x+CGFloat(button_offset))")
            button.frame.origin.x += CGFloat(button_offset)
            buttonOrigin = CGPoint(x: button.frame.origin.x + CGFloat(button_offset), y: button.frame.origin.y)
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
        }
        
        buttonOrigin = CGPoint(x:0,y:0)
        button_offset = 0
        line_offset = LINE_OFFSET
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
        line_offset = LINE_OFFSET*2
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
        line_offset = LINE_OFFSET*3
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
        line_offset = LINE_OFFSET*4
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
        line_offset = LINE_OFFSET*5
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
        line_offset = LINE_OFFSET*6 + LINE_OFFSET_SMALL
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
            
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: button_size))
            setUpButtons(myLabel: key, myFontSize: button_font_size, myButton: button)
            button.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
        }
        
        //        scrollView.contentSize.height = button.center.y + CGFloat(SCROLL_OFFSET)
        self.view.addSubview(scrollView)
        //        foreground.delegate = self
        
    }
    
    //    func scrollViewDidScroll(scrollView: UIScrollView) {
    //
    //        let foregroundHeight = foreground.contentSize.height - foreground.bounds.height
    //        let percentageScroll = foreground.contentOffset.y / foregroundHeight
    //        let backgroundHeight = background.contentSize.height - background.bounds.height
    //
    //        background.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll)
    //    }
    //
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //
    //        scrollView.frame = view.bounds
    //        containerView.frame = CGRect(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
