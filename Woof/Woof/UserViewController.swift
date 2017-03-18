//
//  UserViewController.swift
//  Woof
//
//  Created by Kim Jasper Mui on 3/16/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {

    let myUser: User! = Functionalities.myUser
    
    // Sizes
    let LABEL_SIZE: CGSize = CGSize(width: 330, height: 40)
    let TEXT_SIZE: CGSize = CGSize(width: 330, height: 40)
    let TOP_BUTTONS_SIZE: CGSize = CGSize(width: 80, height: 30)
    let SAVE_BUTTON_SIZE: CGSize = CGSize(width: 330, height: 40)
    let IMAGE_SIZE: CGSize = CGSize(width: 100, height: 100)
    
    // Offsets
    let EDIT_OFFSET = CGFloat(210)
    let FIELD_OFFSET = CGFloat(55)
    let BUTTON_OFFSET = CGFloat(65)
    let IMAGE_OFFSET_X = CGFloat(95)
    let IMAGE_OFFSET_Y = CGFloat(70)
    
    // Configurations
    let FONT = "Rubik"
    let FONT_SIZE = 19
    let CORNER_RADIUS = 10
    let VIEW_UP = 200
    
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
    var editButton: UIButton = UIButton(frame: CGRect(x: 250, y: 175, width: 80, height: 30))
    var imageButton: UIButton = UIButton(frame: CGRect(x: 40, y: 175, width: 80, height: 30))
    var saveButton: UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
    
    // The image
    var profileImage: UIImageView! = UIImageView()
    
    // Colors
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    let green_half: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.8)
    let black : UIColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
    
    let imagePicker = UIImagePickerController()
    
    var iPet: iPetViewController? = nil
    var testString: String = ""
    
    // function to set up the common specs of labels
    func setUpLabel(myText: String, myFont: String, myFontSize: Int, myAlignment: NSTextAlignment, myLabel: UILabel, myColor: UIColor) {
        
        myLabel.text = myText
        myLabel.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myLabel.textAlignment = myAlignment
        myLabel.backgroundColor = myColor
        myLabel.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myLabel.clipsToBounds = true
        self.view.addSubview(myLabel)
    }
    
    // function to set up the common specs of text fields
    func setUpText(myPlaceholder: String, myFont: String, myFontSize: Int, myFontColor: UIColor, myAlignment: NSTextAlignment, myTextField: UITextField, myColor: UIColor) {
        
        myTextField.placeholder = myPlaceholder
        myTextField.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myTextField.textColor = myFontColor
        myTextField.textAlignment = myAlignment
        myTextField.backgroundColor = myColor
        myTextField.clipsToBounds = true
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        myTextField.autocapitalizationType = UITextAutocapitalizationType.words
        myTextField.delegate = self
        myTextField.isHidden = true
        self.view.addSubview(myTextField)
    }
    
    // function to set up the common specs of buttons
    func setUpButtons(myLabel: String, myFontSize: Int, myFontColor: UIColor, myButton: UIButton, myColor: UIColor) {
        
        myButton.setTitle(myLabel, for: UIControlState.normal)
        myButton.setTitleColor(myFontColor, for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont(name: FONT, size: CGFloat(myFontSize))
        myButton.backgroundColor = myColor
        myButton.isUserInteractionEnabled = true
        myButton.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myButton.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControlEvents.touchDown)
        self.view.addSubview(myButton)
    }
    
    func setUpImage(mySource: UIImage, myImage: UIImageView) {
        
        myImage.image = mySource
    }
    
    func setLabelsHidden(myBool: Bool) {
    
        nameLabel.isHidden = myBool
        ageLabel.isHidden = myBool
        genderLabel.isHidden = myBool
        zipLabel.isHidden = myBool
        emailLabel.isHidden = myBool
    }
    
    func setFieldsHidden(myBool: Bool) {
        
        nameField.isHidden = myBool
        ageField.isHidden = myBool
        genderField.isHidden = myBool
        zipField.isHidden = myBool
        emailField.isHidden = myBool
    }
    
    func update() {
        
        // information
        let myName: String = nameField.text!
        let myAge: String = ageField.text!
        let myGender: String = genderField.text!
        let myZip: String = zipField.text!
        let myEmail: String = emailField.text!
        
        // update labels
        nameLabel.text = "Name: \(myName)"
        ageLabel.text = "Age: \(myAge)"
        genderLabel.text = "Gender: \(myGender)"
        zipLabel.text = "Zip Code: \(myZip)"
        emailLabel.text = "Email: \(myEmail)"
        
        // user update
        myUser.setName(name: myName)
        myUser.setAge(age: Int(myAge)!)
        myUser.setGender(gender: myGender)
        myUser.setZipCode(code: myZip)
        myUser.setEmail(email: myEmail)
    }
    
    func goBack() {
        
        print("go back to ipet")
        dismiss(animated: true, completion: nil)
    }
    
    func buttonPressed(sender: UIButton) {
        
        if sender == imageButton {
            
            // image access and assign the image
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
            
            print("my word: \(testString)")
        }
        
        else if sender == editButton {
            
            // hide labels
            setLabelsHidden(myBool: true)
            
            // show text fields and save button
            setFieldsHidden(myBool: false)
            saveButton.isHidden = false
        }
        
        else if sender == saveButton {
            
            // hide text fields and save button
            setFieldsHidden(myBool: true)
            saveButton.isHidden = true
            
            // update labels and user
            update()
            
            // show labels
            setLabelsHidden(myBool: false)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // put up view
        if textField == emailField || textField == zipField || textField == genderField {
            
            self.view.frame.origin.y -= CGFloat(VIEW_UP)
        }
        
        saveButton.isUserInteractionEnabled = false
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        // put back view
        if textField == emailField || textField == zipField || textField == genderField {
            
            self.view.frame.origin.y += CGFloat(VIEW_UP)
        }
        
        textField.enablesReturnKeyAutomatically = true
        
        saveButton.isUserInteractionEnabled = true
    }
    
    func addDoneButtonOnKeyboard(myField: UITextField) {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width:320, height: 50)))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePressed))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        myField.inputAccessoryView = doneToolbar
    }
    
    func donePressed() {
        
        self.ageField.resignFirstResponder()
        self.zipField.resignFirstResponder()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        profileImage.image = chosenImage
        dismiss(animated:true, completion: nil)
        
        // change the image at the ipet page
        let tool: Functionalities = Functionalities()
        tool.addUserImage(chosenImage: profileImage.image!, user: Functionalities.myUser!)
        
        iPet?.userImg.image = profileImage.image
        
    }
    
    // dismiss the selection screen when cancel is pressed
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("in user profile")
        
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
        
        let IMAGE_ORIGIN = CGPoint(x: IMAGE_BUTTON_ORIGIN.x + IMAGE_OFFSET_X, y: IMAGE_BUTTON_ORIGIN.y - IMAGE_OFFSET_Y)
        
        // labels
        let NAME_ORIGIN = CGPoint(x: 20, y: 240)
        let AGE_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: NAME_ORIGIN.y + FIELD_OFFSET)
        let GENDER_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: AGE_ORIGIN.y + FIELD_OFFSET)
        let ZIP_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: GENDER_ORIGIN.y + FIELD_OFFSET)
        let EMAIL_ORIGIN = CGPoint(x: NAME_ORIGIN.x, y: ZIP_ORIGIN.y + FIELD_OFFSET)
        
        // text fields plus save button
        let NAME_TEXT_ORIGIN = CGPoint(x: 20, y: 260)
        let AGE_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: NAME_TEXT_ORIGIN.y + FIELD_OFFSET)
        let GENDER_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: AGE_TEXT_ORIGIN.y + FIELD_OFFSET)
        let ZIP_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: GENDER_TEXT_ORIGIN.y + FIELD_OFFSET)
        let EMAIL_TEXT_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: ZIP_TEXT_ORIGIN.y + FIELD_OFFSET)
        let SAVE_BUTTON_ORIGIN = CGPoint(x: NAME_TEXT_ORIGIN.x, y: EMAIL_TEXT_ORIGIN.y + BUTTON_OFFSET)
        
        // sets up the top buttons
        imageButton = UIButton(frame: CGRect(origin: IMAGE_BUTTON_ORIGIN, size: TOP_BUTTONS_SIZE))
        setUpButtons(myLabel: "image", myFontSize: FONT_SIZE, myFontColor: UIColor.black, myButton: imageButton, myColor: yellow)
        
        // sets up the image picker
        imagePicker.delegate = self
        
        profileImage = UIImageView(frame: CGRect(origin: IMAGE_ORIGIN, size: IMAGE_SIZE))
        profileImage.setRound()
        let tool: Functionalities = Functionalities()
        tool.retrieveUserImage(UIImageView: profileImage)
        self.view.addSubview(profileImage)
        // setUpImage(myURL: "", myImage: profileImage)
        
        editButton = UIButton(frame: CGRect(origin: EDIT_BUTTON_ORIGIN, size: TOP_BUTTONS_SIZE))
        setUpButtons(myLabel: "edit", myFontSize: FONT_SIZE, myFontColor: UIColor.black, myButton: editButton, myColor: yellow)
        
        // sets up the text fields
        nameField = UITextField(frame: CGRect(origin: NAME_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Name", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: nameField, myColor: UIColor.white)
        nameField.text = myUser.getName()
        
        ageField = UITextField(frame: CGRect(origin: AGE_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Age", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: ageField, myColor: UIColor.white)
        ageField.keyboardType = UIKeyboardType.numberPad
        addDoneButtonOnKeyboard(myField: ageField)
        ageField.text = "\(myUser.getAge())"
        
        genderField = UITextField(frame: CGRect(origin: GENDER_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Gender", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: genderField, myColor: UIColor.white)
        genderField.text = myUser.getGender()
        
        zipField = UITextField(frame: CGRect(origin: ZIP_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Zip", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: zipField, myColor: UIColor.white)
        zipField.keyboardType = UIKeyboardType.numberPad
        addDoneButtonOnKeyboard(myField: zipField)
        zipField.text = myUser.getZipCode()
        
        emailField = UITextField(frame: CGRect(origin: EMAIL_TEXT_ORIGIN, size: TEXT_SIZE))
        setUpText(myPlaceholder: "Email", myFont: FONT, myFontSize: FONT_SIZE, myFontColor: UIColor.blue, myAlignment: NSTextAlignment.center, myTextField: emailField, myColor: UIColor.white)
        emailField.text = myUser.getEmail()
        
        // sets up the labels
        nameLabel = UILabel(frame: CGRect(origin: NAME_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Name: \(nameField.text!)", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: nameLabel, myColor: green_half)
        
        ageLabel = UILabel(frame: CGRect(origin: AGE_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Age: \(ageField.text!)", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: ageLabel, myColor: green_half)
        
        genderLabel = UILabel(frame: CGRect(origin: GENDER_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Gender: \(genderField.text!)", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: genderLabel, myColor: green_half)
        
        zipLabel = UILabel(frame: CGRect(origin: ZIP_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Zip Code: \(zipField.text!)", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: zipLabel, myColor: green_half)
        
        emailLabel = UILabel(frame: CGRect(origin: EMAIL_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: "Email: \(emailField.text!)", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: emailLabel, myColor: green_half)
        
        // sets up the save button
        saveButton = UIButton(frame: CGRect(origin: SAVE_BUTTON_ORIGIN, size: SAVE_BUTTON_SIZE))
        setUpButtons(myLabel: "save", myFontSize: FONT_SIZE, myFontColor: UIColor.white, myButton: saveButton, myColor: UIColor.black)
        saveButton.isHidden = true
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
