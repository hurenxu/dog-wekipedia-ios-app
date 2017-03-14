//
//  OwnedDogDetailViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/28/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit
import FirebaseStorage

class OwnedDogDetailViewController: UIViewController, UINavigationBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var name = ""
    var gender = ""
    var vaccinationdate = ""
    var birthdate = ""
    var discription = ""
    var breed = ""
    var age = ""
    
    var flag = false
    
    var ageData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    var picker = UIPickerView()
    var picker2 = UIPickerView()
    var picker3 = UIPickerView()
    //var picker2 = UIDatePicker()
    
    // testing
    let myUser = Functionalities.myUser
    var thisDogID = ""
    var thisDog: Dog?
    
    //var Img =  UIImage()
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    let green_half: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.8)
    let black : UIColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
    
    
    
    //Declare the texctfield in this view
    var dogNametextField = UITextField(frame: CGRect(20.0, 230, 330.0, 40.0))
    var dogGendertextField = UITextField(frame: CGRect(20.0, 275, 330.0, 40.0))
    var dogBirhDatetextField = UITextField(frame: CGRect(20.0, 320, 330.0, 40.0))
    var dogVaccinationDatetextField = UITextField(frame: CGRect(20.0, 365, 330.0, 40.0))
    var breedtextField = UITextField(frame: CGRect(20.0, 410, 330.0, 40.0))
    var agetextField = UITextField(frame: CGRect(20.0, 455, 330.0, 40.0))
    
    
    
    
    //Declare the button in this view
    let editProfButton:UIButton = UIButton(frame: CGRect(x: 250, y: 175, width: 80, height: 30))
    let saveProfButton:UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
    let changeImageButton:UIButton = UIButton(frame: CGRect(x: 40, y: 175, width: 80, height: 30))
    
    
    
    //Declare nameLabel of the dog
    let nameLabel = UILabel(frame: CGRect(x: 20, y: 240, width: 330, height: 40))
    
    //Declare the genderLabel of the dog
    let genderLabel = UILabel(frame: CGRect(x: 20, y: 295, width: 330, height: 40))
    
    //Declare BirthDate Label
    let birthDateLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 330, height: 40))
    
    //Declare Vaccination Date Label
    let vaccinationDateLabel = UILabel(frame: CGRect(x: 20, y: 405, width: 330, height: 40))
    
    
    //Declare the breed Label
    let breedLabel = UILabel(frame: CGRect(x: 20, y: 460, width: 330, height: 40))
    
    //Declare the age Label
    let ageLabel = UILabel(frame: CGRect(x: 20, y: 515, width: 330, height: 40))
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == breedtextField && flag == false{
            
            
            self.view.frame.origin.y -= CGFloat(200)
            flag = true
        }
        
        return true
    }
    
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        self.view.backgroundColor = white
        
        
        //Img = self.convertBase64ToImage(base64String: (thisDog?.image)!)
        print(name)
        // Do any additional setup after loading the view.
        
        picker.delegate = self
        picker.dataSource = self
        agetextField.inputView = picker
        
        
        picker2.delegate = self
        picker2.dataSource = self
        
        picker3.delegate = self
        picker3.dataSource = self
        
        
        self.title = "My dog"
        
        
        //nameLabel of the dog
        //    let nameLabel = UILabel(frame: CGRect(x: 200, y: 250, width: 200, height: 200))
        //    nameLabel.center = CGPoint(x: 20, y: 250)
        nameLabel.textAlignment = .center
        nameLabel.text = "Name: " + name
        nameLabel.textColor = UIColor.black
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.font = UIFont(name: "Rubik-Medium", size: 20)
        nameLabel.backgroundColor = green_half
        nameLabel.layer.cornerRadius = 5
        nameLabel.clipsToBounds = true
        view.addSubview(nameLabel)
        
        
        // let genderLabel = UILabel(frame: CGRect(x: 200, y: 250, width: 200, height: 200))
        //     genderLabel.center = CGPoint(x: 20, y: 300)
        genderLabel.textAlignment = .center
        
        genderLabel.text = "Gender: " + (thisDog?.gender)!
        genderLabel.textColor = UIColor.black
        genderLabel.font = genderLabel.font.withSize(30)
        genderLabel.font = UIFont(name: "Rubik", size: 19)
        genderLabel.backgroundColor = green_half
        genderLabel.layer.cornerRadius = 5
        genderLabel.clipsToBounds = true
        view.addSubview(genderLabel)
        
        
        //change format
        let newdateFormatter1 = DateFormatter()
        newdateFormatter1.dateStyle = .long
        newdateFormatter1.timeStyle = .none
        let strBir = newdateFormatter1.string(from: (thisDog?.birthDate)!)
        
        //      birthDateLabel.center = CGPoint(x: 20, y: 350)
        birthDateLabel.textAlignment = .center
        birthDateLabel.text = "Birth Date: " + strBir
        birthDateLabel.textColor = UIColor.black
        birthDateLabel.font = birthDateLabel.font.withSize(30)
        birthDateLabel.font = UIFont(name: "Rubik", size: 19)
        birthDateLabel.backgroundColor = green_half
        birthDateLabel.layer.cornerRadius = 5
        birthDateLabel.clipsToBounds = true
        view.addSubview(birthDateLabel)
        
        
        
        
        //Label of the vaccination date
        //change format
        let strVac = newdateFormatter1.string(from: (thisDog?.vaccination)!)
        //     vaccinationDateLabel.center = CGPoint(x: 20, y: 400)
        vaccinationDateLabel.textAlignment = .center
        vaccinationDateLabel.text = "Vaccination Date: " + strVac
        vaccinationDateLabel.textColor = UIColor.black
        vaccinationDateLabel.font = vaccinationDateLabel.font.withSize(30)
        vaccinationDateLabel.font = UIFont(name: "Rubik", size: 16)
        vaccinationDateLabel.backgroundColor = green_half
        vaccinationDateLabel.layer.cornerRadius = 5
        vaccinationDateLabel.clipsToBounds = true
        view.addSubview(vaccinationDateLabel)
        
        
        //breed Label
        breedLabel.textAlignment = .center
        breedLabel.text = "Breed: " + (thisDog?.breed.breedName)!
        breedLabel.textColor = UIColor.black
        breedLabel.font = breedLabel.font.withSize(30)
        breedLabel.font = UIFont(name: "Rubik", size: 19)
        breedLabel.backgroundColor = green_half
        breedLabel.layer.cornerRadius = 5
        breedLabel.clipsToBounds = true
        view.addSubview(breedLabel)
        breedtextField.text = breed
        
        
        //age Label
        ageLabel.textAlignment = .center
        ageLabel.text = "Age: " + (thisDog?.age)!
        ageLabel.textColor = UIColor.black
        ageLabel.font = ageLabel.font.withSize(30)
        ageLabel.font = UIFont(name: "Rubik", size: 19)
        ageLabel.backgroundColor = green_half
        ageLabel.layer.cornerRadius = 5
        ageLabel.clipsToBounds = true
        view.addSubview(ageLabel)
        
        
        
        
        //---------------------------------------------------------------------------------------------------------------------
        /* user profile image */
        let dogImg = profileImgContainer
        dogImg.setRounded()
        self.view.addSubview(dogImg)
        ImageViewConstraints(Img: dogImg)
        
        self.title = "My dog"
        
        //self.view.addSubview(backButton)
        
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:58)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "My dog"
        
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        self.view.addSubview(navigationBar)
        
        
        
        //The edit Button
        //    let editProfButton:UIButton = UIButton(frame: CGRect(x: 250, y: 200, width: 50, height: 25))
        editProfButton.backgroundColor = yellow
        editProfButton.setTitle("edit", for: .normal)
        editProfButton.setTitleColor(UIColor.black, for: .normal)
        editProfButton.layer.cornerRadius = 5
        editProfButton.clipsToBounds = true
        self.view.addSubview(editProfButton)
        //   EditProfileImageButtonConstraints(Button: editProfButton)
        editProfButton.addTarget(self, action: #selector(editProfButtonClick), for: UIControlEvents.touchUpInside)
        
        //The Save Button
        //    let saveProfButton:UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
        saveProfButton.backgroundColor = .black
        saveProfButton.setTitle("Save", for: .normal)
        self.view.addSubview(saveProfButton)
        //  EditProfileImageButtonConstraints(Button: editProfButton)
        saveProfButton.addTarget(self, action: #selector(saveProfButtonClick), for: UIControlEvents.touchUpInside)
        saveProfButton.isHidden = true
        
        changeImageButton.backgroundColor = yellow
        changeImageButton.setTitle("image", for: .normal)
        changeImageButton.setTitleColor(.black, for: .normal)
        //     changeImageButton.layer.borderWidth = 0.5
        //     changeImageButton.layer.borderColor = UIColor.blue.cgColor
        
        self.view.addSubview(changeImageButton)
        //  EditProfileImageButtonConstraints(Button: editProfButton)
        changeImageButton.layer.cornerRadius = 5
        changeImageButton.clipsToBounds = true
        changeImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
        
        
        //    var dogNametextField = UITextField(frame: CGRect(20.0, 350.0, 330.0, 40.0))
        dogNametextField.textAlignment = NSTextAlignment.center
        dogNametextField.textColor = UIColor.blue
        dogNametextField.borderStyle = UITextBorderStyle.roundedRect
        dogNametextField.placeholder = "Name"
        dogNametextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogNametextField)
        dogNametextField.isHidden = true
        
        self.dogNametextField.delegate = self;
        
        //     var dogGendertextField = UITextField(frame: CGRect(20.0, 400.0, 330.0, 40.0))
        dogGendertextField.textAlignment = NSTextAlignment.center
        dogGendertextField.textColor = UIColor.blue
        dogGendertextField.borderStyle = UITextBorderStyle.roundedRect
        dogGendertextField.placeholder = "Gender"
        dogGendertextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogGendertextField)
        dogGendertextField.isHidden = true
        
        self.dogGendertextField.delegate = self;    // so it can hide after user press on enter
        
        //     var dogBirhDatetextField = UITextField(frame: CGRect(20.0, 450.0, 330.0, 40.0))
        dogBirhDatetextField.textAlignment = NSTextAlignment.center
        dogBirhDatetextField.textColor = UIColor.blue
        dogBirhDatetextField.borderStyle = UITextBorderStyle.roundedRect
        dogBirhDatetextField.placeholder = "Birthdate"
        dogBirhDatetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogBirhDatetextField)
        dogBirhDatetextField.isHidden = true
        
        self.dogBirhDatetextField.delegate = self;
        
        //   var dogVaccinationDatetextField = UITextField(frame: CGRect(20.0, 500.0, 330.0, 40.0))
        dogVaccinationDatetextField.textAlignment = NSTextAlignment.center
        dogVaccinationDatetextField.textColor = UIColor.blue
        dogVaccinationDatetextField.borderStyle = UITextBorderStyle.roundedRect
        dogVaccinationDatetextField.placeholder = "Vaccination Test Date"
        dogVaccinationDatetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogVaccinationDatetextField)
        dogVaccinationDatetextField.isHidden = true
        
        
        agetextField.textAlignment = NSTextAlignment.center
        agetextField.textColor = UIColor.blue
        agetextField.borderStyle = UITextBorderStyle.roundedRect
        agetextField.placeholder = "Age"
        agetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(agetextField)
        agetextField.isHidden = true
        
        
        breedtextField.textAlignment = NSTextAlignment.center
        breedtextField.textColor = UIColor.blue
        breedtextField.borderStyle = UITextBorderStyle.roundedRect
        breedtextField.placeholder = "Breed"
        breedtextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(breedtextField)
        breedtextField.isHidden = true
        breedtextField.delegate = self
        
        
        picker2.center = CGPoint(x: 180, y: 560)
        picker2.backgroundColor = UIColor.white
        picker2.layer.masksToBounds = true
        picker2.layer.cornerRadius = CGFloat(20)
        
        self.textFieldEditing(sender: dogVaccinationDatetextField)
        picker2.isHidden = true
        
        //picker2.datePickerMode = UIDatePickerMode.date
        
        self.view.addSubview(picker2)
        
        
        picker3.center = CGPoint(x: 180, y: 560)
        picker3.backgroundColor = UIColor.white
        
        picker3.layer.masksToBounds = true
        picker3.layer.cornerRadius = CGFloat(20)
        
        self.textFieldEditing2(sender: dogBirhDatetextField)
        picker3.isHidden = true
        
        //picker2.datePickerMode = UIDatePickerMode.date
        
        self.view.addSubview(picker3)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int, inComponent component : Int)
    {
        agetextField.text = ageData[row]
        self.view.endEditing(true)
    }
    
    func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(OwnedDogDetailViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func textFieldEditing2(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(OwnedDogDetailViewController.datePickerValueChanged2), for: UIControlEvents.valueChanged)
    }
    
    
    
    
    func datePickerValueChanged(datePicker:UIDatePicker) {
        
        datePicker.isHidden = false
        self.view.endEditing(true)
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let strDate = dateFormatter.string(from: datePicker.date)
        
        dogVaccinationDatetextField.text = strDate
        vaccinationDateLabel.text = strDate
    }
    
    
    func datePickerValueChanged2(datePicker:UIDatePicker) {
        
        datePicker.isHidden = false
        self.view.endEditing(true)
        let dateFormatter: DateFormatter = DateFormatter()
        
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let strDate = dateFormatter.string(from: datePicker.date)
        
        dogBirhDatetextField.text = strDate
        birthDateLabel.text = strDate
        
        
        //datePicker.isHidden = true
    }
    
    
    
    
    //Action when user clicks the Save Button
    func saveProfButtonClick(sender:UIButton!)
    {
        print("The Save Button has been clicked")
        
        dogVaccinationDatetextField.isHidden = true
        dogBirhDatetextField.isHidden = true
        dogGendertextField.isHidden = true
        dogNametextField.isHidden = true
        agetextField.isHidden = true
        breedtextField.isHidden = true
        saveProfButton.isHidden = true
        
        
        name = dogNametextField.text!
        gender = dogGendertextField.text!
        vaccinationdate = dogVaccinationDatetextField.text!
        birthdate = dogBirhDatetextField.text!
        age = agetextField.text!
        breed = breedtextField.text!
        
        nameLabel.text = "Name: " + name
        genderLabel.text = "Gender: " + gender
        birthDateLabel.text = "Birth Date: " + birthdate
        vaccinationDateLabel.text = "Vaccination Date: " + vaccinationdate
        ageLabel.text = "Age: " + age
        breedLabel.text = "Breed: " + breed
        
        nameLabel.isHidden = false
        genderLabel.isHidden = false
        birthDateLabel.isHidden = false
        vaccinationDateLabel.isHidden = false
        breedLabel.isHidden = false
        ageLabel.isHidden = false
        breedLabel.isHidden = false
        
        if (name == "") {
            name = (thisDog?.name)!
        }
        if (gender == "") {
            gender = (thisDog?.gender)!
        }
        if (age == "") {
            age = (thisDog?.age)!
        }
        let newBreed: Breed
        if (breed == "") {
            newBreed = (thisDog?.breed)!
        }
        else {
            
            
            //print(breed)
            newBreed = Breed(breedName: breed, popularity: (thisDog?.breed.popularity)!, origin: (thisDog?.breed.origin)!, group: (thisDog?.breed.group)!, size: (thisDog?.breed.size)!, type: (thisDog?.breed.type)!, lifeExpectancy: (thisDog?.breed.lifeExpectancy)!, personality: (thisDog?.breed.personality)!,
                             height: (thisDog?.breed.height)!, weight: (thisDog?.breed.weight)!,
                             colors: (thisDog?.breed.colors)!, litterSize: (thisDog?.breed.litterSize)!, price: (thisDog?.breed.price)!, barkingLevel: (thisDog?.breed.barkingLevel)!, childFriendly: (thisDog?.breed.childFriendly)!,
                             
                             grooming: (thisDog?.breed.grooming)!,shedding: (thisDog?.breed.shedding)!, trainability: (thisDog?.breed.trainability)!,
                             breeders: (thisDog?.breed.breeders)!, image: (thisDog?.breed.image)!)
        }
        let newBirthDate: Date
        let newVaccineDate: Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        if (birthdate == "") {
            newBirthDate = (thisDog?.birthDate)!
        }
        else {
            
            newBirthDate = dateFormatter.date(from: birthdate)!
        }
        
        if (vaccinationdate == "") {
            newVaccineDate = (thisDog?.vaccination)!
        }
        else {
            newVaccineDate = dateFormatter.date(from: vaccinationdate)!
        }
        
        
        let newDog = Dog(dogID: (thisDog?.dogID)!, name: name, breed: newBreed, birthDate: newBirthDate,age: age, gender: gender,  vaccination: newVaccineDate, color: (thisDog?.color)!, description: (thisDog?.description)!, image: (thisDog?.image)!)
        
        print(newDog.name)
        print(newDog.dogID)
        print(newDog.breed.breedName)
        breed = newDog.breed.breedName
        
        print(newDog.birthDate)
        print(newDog.gender)
        print(newDog.vaccination)
        print(newDog.color)
        print(newDog.description)
        print(newDog.image)
        
        Functionalities.myUser?.updateDog(dog: newDog)
        
        self.view.frame.origin.y = 0
        flag = false
    }
    
    //Action when user clicks the edit Button
    func editProfButtonClick(sender:UIButton)
    {
        dogVaccinationDatetextField.isHidden = false
        dogVaccinationDatetextField.text = vaccinationdate
        
        dogBirhDatetextField.isHidden = false
        dogBirhDatetextField.text = birthdate
        
        
        dogGendertextField.isHidden = false
        dogGendertextField.text = gender
        
        dogNametextField.isHidden = false
        dogNametextField.text = name
        
        
        agetextField.isHidden = false
        agetextField.text = age
        
        
        breedtextField.isHidden = false
        
        
        
        
        saveProfButton.isHidden = false
        
        
        nameLabel.isHidden = true
        genderLabel.isHidden = true
        birthDateLabel.isHidden = true
        vaccinationDateLabel.isHidden = true
        breedLabel.isHidden = true
        ageLabel.isHidden = true
        breedLabel.isHidden = true
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    //---------------------------function about picker-----------------------------------------------------------
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return ageData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component : Int)->String?
    {
        return ageData[row]
    }
    
    
    
    //--------------------------------end picker------------------------------------------------------------------
    
    
    func goBack(){
        print("call goBack function")
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "iPetViewController") as! iPetViewController
        //        self.present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var profileImgContainer: UIImageView = {
        let ImgView = UIImageView()
        //let anyImg = UIImage(named:"")
        var Img = UIImage(named: "BlackEmptyDog")

        ImgView.image = Img
        //ImgView.image = convertBase64ToImage(thisDog.image)
        
        
        //ImgView.image = convertBase64ToImage(base64String: (thisDog?.image)!)
        ImgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ImgView.translatesAutoresizingMaskIntoConstraints = false
        
        return ImgView
    }()
    
    
    /* layout constriants for profile image */
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 100).isActive = true
    }
    
    
    /* function: add an UIImagePickerController */
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        print("in adding dog view gesture recognizing")
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    /* imagePickerController & imagePickerControllerDidCancel handle the pop over and dismissal of profile changing */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var chosenImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            chosenImageFromPicker = editedImage
        }
        
        if let chosenImage = chosenImageFromPicker {
            profileImgContainer.image = chosenImage
            
            let tools = Functionalities()
            tools.addDogImage(chosenImage: chosenImage, dog: thisDog!)
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

//used to replace CGRectMake
extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
