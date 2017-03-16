//
//  UserViewController.swift
//  Woof
//
//  Created by Kim Jasper Mui on 3/16/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    let myUser = Functionalities.myUser
    
    // Sizes
    let LABEL_SIZE: CGSize = CGSize(width: 330, height: 40)
    let TEXT_SIZE: CGSize = CGSize(width: 330, height: 40)
    let TOP_BUTTONS_SIZE: CGSize = CGSize(width: 80, height: 30)
    let SAVE_BUTTON_SIZE: CGSize = CGSize(width: 330, height: 40)
    
    // Offsets
    let EDIT_OFFSET = CGFloat(210)
    let FIELD_OFFSET = CGFloat(55)
    
    // Configurations
    let FONT = "Rubik"
    let FONT_SIZE = 19
    let CORNER_RADIUS = 10
    
    // Labels
    var nameLabel: UILabel! = nil
    var ageLabel: UILabel! = nil
    var genderLabel: UILabel! = nil
    var zipLabel: UILabel! = nil
    var emailLabel: UILabel! = nil

    // Text fields
    var nameField: UITextField! = nil
    var ageField: UITextField! = nil
    var genderField: UITextField! = nil
    var zipField: UITextField! = nil
    var emailField: UITextField! = nil
    
    // Buttons
    let editButton:UIButton = UIButton(frame: CGRect(x: 250, y: 175, width: 80, height: 30))
    let imageButton:UIButton = UIButton(frame: CGRect(x: 40, y: 175, width: 80, height: 30))
    let saveButton:UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
    
    // Colors
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    let green_half: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.8)
    let black : UIColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
    
    // function to set up the common specs of labels
    func setUpLabel(myText: String, myFont: String, myFontSize: Int, myAlignment: NSTextAlignment, myLabel: UILabel, myColor: UIColor) {
        
        myLabel.text = myText
        myLabel.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myLabel.textAlignment = myAlignment
        myLabel.backgroundColor = myColor
        myLabel.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myLabel.clipsToBounds = true
        myLabel.isHidden = true
        self.view.addSubview(myLabel)
    }
    
    // function to set up the common specs of text fields
    func setUpText(myPlaceholder: String, myFont: String, myFontSize: Int, myFontColor: UIColor, myAlignment: NSTextAlignment, myTextField: UITextField, myColor: UIColor) {
        
        myTextField.placeholder = myPlaceholder
        myTextField.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myTextField.textColor = myFontColor
        myTextField.textAlignment = myAlignment
        myTextField.backgroundColor = myColor
        myTextField.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myTextField.clipsToBounds = true
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        myTextField.autocapitalizationType = UITextAutocapitalizationType.words
        myTextField.delegate = self
        self.view.addSubview(myTextField)
    }
    
    func goBack() {
        
        print("go back to ipet")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // background
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge-shade.jpg")!)
        self.view.backgroundColor = UIColor.white
        
        // sets up the navigation bar
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "My Profile"
        navigationItem.leftBarButtonItem = backButton
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 65))
        navigationBar.pushItem(navigationItem, animated: true)
        navigationBar.delegate = self;

        self.view.addSubview(navigationBar)
        
        // origins
        // top buttons
        let IMAGE_BUTTON_ORIGIN = CGPoint(x: 40, y: 175)
        let EDIT_BUTTON_ORIGIN = CGPoint(x: IMAGE_BUTTON_ORIGIN.x + EDIT_OFFSET, y: IMAGE_BUTTON_ORIGIN.y)
        
        // labels
        let NAME_ORIGIN = CGPoint(x: 20, y: 240)
        let AGE_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: NAME_ORIGIN.y + FIELD_OFFSET)
        let GENDER_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: AGE_ORIGIN.y + FIELD_OFFSET)
        let ZIP_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: GENDER_ORIGIN.y + FIELD_OFFSET)
        let EMAIL_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: ZIP_ORIGIN.y + FIELD_OFFSET)
        
        // text fields plus save button
        let NAME_TEXT_ORIGIN = CGPoint(x: 20, y: 230)
        let AGE_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: NAME_TEXT_ORIGIN.y + FIELD_OFFSET)
        let GENDER_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: AGE_TEXT_ORIGIN.y + FIELD_OFFSET)
        let ZIP_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: GENDER_TEXT_ORIGIN.y + FIELD_OFFSET)
        let EMAIL_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: ZIP_TEXT_ORIGIN.y + FIELD_OFFSET)
        let SAVE_BUTTON_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: ZIP_TEXT_ORIGIN.y + FIELD_OFFSET)
        
        // sets up the labels
        nameLabel = UILabel(frame: CGRect(origin: NAME_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Name: ", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: nameLabel, myColor: green_half)
        
        ageLabel = UILabel(frame: CGRect(origin: AGE_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Age: ", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: ageLabel, myColor: green_half)
        
        genderLabel = UILabel(frame: CGRect(origin: GENDER_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "gender: ", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: genderLabel, myColor: green_half)
        
        zipLabel = UILabel(frame: CGRect(origin: ZIP_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Zip Code: ", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: zipLabel, myColor: green_half)
        
        emailLabel = UILabel(frame: CGRect(origin: EMAIL_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Email: ", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: emailLabel, myColor: green_half)
        
        // sets up the text fields
        nameField = UITextField(frame: CGRect(origin: NAME_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Name", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: nameField, myColor: UIColor.white)
        
        ageField = UITextField(frame: CGRect(origin: AGE_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Age", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: ageField, myColor: UIColor.white)
        
        genderField = UITextField(frame: CGRect(origin: GENDER_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Gender", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: genderField, myColor: UIColor.white)
        
        zipField = UITextField(frame: CGRect(origin: ZIP_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Zip", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: zipField, myColor: UIColor.white)
        
        emailField = UITextField(frame: CGRect(origin: EMAIL_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Email", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: emailField, myColor: UIColor.white)
        
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
