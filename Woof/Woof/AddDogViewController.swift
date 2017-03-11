//
//  AddDogViewController.swift
//  Woof
//
//  Created by Meiyi He on 3/9/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class AddDogViewController: UIViewController, UINavigationBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var name = ""
    var gender = ""
    var vaccinationdate = ""
    var birthdate = ""
    var discription = ""
    var breed = ""
    var age = ""
    
    var ageData = ["1","2","3","4","5","6","7","8","9","10"]
    var picker = UIPickerView()
    var picker2 = UIPickerView()
    //var picker2 = UIDatePicker()
    
    
    
    //Declare the texctfield in this view
    var dogNametextField = UITextField(frame: CGRect(20.0, 230, 330.0, 40.0))
    var dogGendertextField = UITextField(frame: CGRect(20.0, 275, 330.0, 40.0))
    var dogBirhDatetextField = UITextField(frame: CGRect(20.0, 320, 330.0, 40.0))
    var dogVaccinationDatetextField = UITextField(frame: CGRect(20.0, 365, 330.0, 40.0))
    var breedtextField = UITextField(frame: CGRect(20.0, 410, 330.0, 40.0))
    var agetextField = UITextField(frame: CGRect(20.0, 455, 330.0, 40.0))

    let editProfButton:UIButton = UIButton(frame: CGRect(x: 250, y: 170, width: 50, height: 25))
    let saveProfButton:UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
    
    
    //Declare nameLabel of the dog
    let nameLabel = UILabel(frame: CGRect(x: 20, y: 230, width: 330, height: 40))
    
    //Declare the genderLabel of the dog
    let genderLabel = UILabel(frame: CGRect(x: 20, y: 275, width: 330, height: 40))
    
    //Declare BirthDate Label
    let birthDateLabel = UILabel(frame: CGRect(x: 20, y: 320, width: 330, height: 40))
    
    //Declare Vaccination Date Label
    let vaccinationDateLabel = UILabel(frame: CGRect(x: 20, y: 365, width: 330, height: 40))
    
    
    //Declare the breed Label
    let breedLabel = UILabel(frame: CGRect(x: 20, y: 410, width: 330, height: 40))
    
    //Declare the age Label
    let ageLabel = UILabel(frame: CGRect(x: 20, y: 455, width: 330, height: 40))


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let dogImg = profileImgContainer
        dogImg.setRounded()
        
        
        editProfButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        editProfButton.setTitle("Edit", for: .normal)
        self.view.addSubview(editProfButton)
        //      EditProfileImageButtonConstraints(Button: editProfButton)
        editProfButton.setTitleColor(.black, for: .normal)
        //editProfButton.setTitleColor(clock:UIColor.black?, for: .normal)
        editProfButton.layer.cornerRadius = 5
        editProfButton.clipsToBounds = true
        /* action when user click on button --> call handleSelectProfileImageView function */
        editProfButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))

        saveProfButton.backgroundColor = .black
        saveProfButton.setTitle("Save", for: .normal)
        self.view.addSubview(saveProfButton)
        //  EditProfileImageButtonConstraints(Button: editProfButton)
        saveProfButton.addTarget(self, action: #selector(saveProfButtonClick), for: UIControlEvents.touchUpInside)
        saveProfButton.isHidden = true
        
        
        
        self.view.addSubview(dogImg)
        ImageViewConstraints(Img: dogImg)
        
        //self.view.addSubview(backButton)
        
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:58)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Add New Dog !"
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        self.view.addSubview(navigationBar)
        
        nameLabel.textAlignment = .center
        nameLabel.text = "Name: " + name
        nameLabel.textColor = UIColor.white
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.font = UIFont(name: "Rubik", size: 25)
        nameLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        nameLabel.layer.cornerRadius = 5
        nameLabel.clipsToBounds = true
        view.addSubview(nameLabel)
        
        
        ageLabel.textAlignment = .center
        ageLabel.text = "Age: " + age
        ageLabel.textColor = UIColor.white
        ageLabel.font = ageLabel.font.withSize(30)
        ageLabel.font = UIFont(name: "Rubik", size: 25)
        ageLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        ageLabel.layer.cornerRadius = 5
        ageLabel.clipsToBounds = true
        view.addSubview(ageLabel)

        
        
        dogNametextField.textAlignment = NSTextAlignment.center
        dogNametextField.textColor = UIColor.blue
        dogNametextField.borderStyle = UITextBorderStyle.roundedRect
        dogNametextField.placeholder = "Name"
        dogNametextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogNametextField)
        dogNametextField.isHidden = true
        
        self.dogNametextField.delegate = self;

        genderLabel.textAlignment = .center
        
        genderLabel.text = "Gender: " + gender
        genderLabel.textColor = UIColor.white
        genderLabel.font = genderLabel.font.withSize(30)
        genderLabel.font = UIFont(name: "Rubik", size: 25)
        genderLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        genderLabel.layer.cornerRadius = 5
        genderLabel.clipsToBounds = true
        view.addSubview(genderLabel)
        
        //     var dogGendertextField = UITextField(frame: CGRect(20.0, 400.0, 330.0, 40.0))
        dogGendertextField.textAlignment = NSTextAlignment.center
        dogGendertextField.textColor = UIColor.blue
        dogGendertextField.borderStyle = UITextBorderStyle.roundedRect
        dogGendertextField.placeholder = "Gender"
        dogGendertextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogGendertextField)
        dogGendertextField.isHidden = true
        
        self.dogGendertextField.delegate = self;    // so it can hide after user press on enter

        
        birthDateLabel.textAlignment = .center
        birthDateLabel.text = "Birth Date: " + gender
        birthDateLabel.textColor = UIColor.white
        birthDateLabel.font = birthDateLabel.font.withSize(30)
        birthDateLabel.font = UIFont(name: "Rubik", size: 25)
        birthDateLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        birthDateLabel.layer.cornerRadius = 5
        birthDateLabel.clipsToBounds = true
        view.addSubview(birthDateLabel)
        
        dogBirhDatetextField.textAlignment = NSTextAlignment.center
        dogBirhDatetextField.textColor = UIColor.blue
        dogBirhDatetextField.borderStyle = UITextBorderStyle.roundedRect
        dogBirhDatetextField.placeholder = "Birthdate"
        dogBirhDatetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogBirhDatetextField)
        dogBirhDatetextField.isHidden = true
        
        self.dogBirhDatetextField.delegate = self;

        
        vaccinationDateLabel.textAlignment = .center
        vaccinationDateLabel.text = "Vaccination Date: " + gender
        vaccinationDateLabel.textColor = UIColor.white
        vaccinationDateLabel.font = vaccinationDateLabel.font.withSize(30)
        vaccinationDateLabel.font = UIFont(name: "Rubik", size: 25)
        vaccinationDateLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        vaccinationDateLabel.layer.cornerRadius = 5
        vaccinationDateLabel.clipsToBounds = true
        view.addSubview(vaccinationDateLabel)
        
        dogVaccinationDatetextField.textAlignment = NSTextAlignment.center
        dogVaccinationDatetextField.textColor = UIColor.blue
        dogVaccinationDatetextField.borderStyle = UITextBorderStyle.roundedRect
        dogVaccinationDatetextField.placeholder = "Vaccination Test Date"
        dogVaccinationDatetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogVaccinationDatetextField)
        dogVaccinationDatetextField.isHidden = true

        
        breedLabel.textAlignment = .center
        breedLabel.text = "Breed: " + breed
        breedLabel.textColor = UIColor.white
        breedLabel.font = breedLabel.font.withSize(30)
        breedLabel.font = UIFont(name: "Rubik", size: 25)
        breedLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        breedLabel.layer.cornerRadius = 5
        breedLabel.clipsToBounds = true
        view.addSubview(breedLabel)
        
        agetextField.textAlignment = NSTextAlignment.center
        agetextField.textColor = UIColor.blue
        agetextField.borderStyle = UITextBorderStyle.roundedRect
        agetextField.placeholder = "Age"
        agetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(agetextField)
        agetextField.isHidden = true

        self.editProfButtonClick()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack(){
        print("call goBack function")

        dismiss(animated: true, completion: nil)
    }
    
    //Action when user clicks the edit Button
    func editProfButtonClick()
    {
        dogVaccinationDatetextField.isHidden = true
        dogBirhDatetextField.isHidden = false
        dogGendertextField.isHidden = false
        dogNametextField.isHidden = false
        agetextField.isHidden = false
        saveProfButton.isHidden = false
        
        nameLabel.isHidden = true
        genderLabel.isHidden = true
        birthDateLabel.isHidden = true
        vaccinationDateLabel.isHidden = true
        breedLabel.isHidden = true
        ageLabel.isHidden = true
        
        
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
        saveProfButton.isHidden = true
        
        name = dogNametextField.text!
        gender = dogGendertextField.text!
        vaccinationdate = dogVaccinationDatetextField.text!
        birthdate = dogBirhDatetextField.text!
        age = agetextField.text!
        
        nameLabel.text = "Name: " + name
        genderLabel.text = "Gender: " + gender
        birthDateLabel.text = "Birth Date: " + birthdate
        vaccinationDateLabel.text = "Vaccination Date: " + vaccinationdate
        ageLabel.text = "Age: " + age
        
        nameLabel.isHidden = false
        genderLabel.isHidden = false
        birthDateLabel.isHidden = false
        vaccinationDateLabel.isHidden = false
        breedLabel.isHidden = false
        ageLabel.isHidden = false
        
        
//        let ageLabelInt = Int(ageLabel.text!)
        
        let breed = Breed(breedName: "York", popularity: "", origin: "", group: "", size: "", type: "", lifeExpectancy: "", personality: "",
                               height: "", weight: "",
                               colors: "", litterSize: "", price: "", barkingLevel: "", childFriendly: "",
                               
                               grooming: "",shedding: "", trainability: "",
                               breeders: "", image: "")
        //update the dog to the database
        let dogID = (Functionalities.myUser?.userID)! + (Functionalities.myUser?.dogIDs.count.description)!
        
        
        if (nameLabel.text == nil){
           nameLabel.text = "Lexi"
        }
        
        if (ageLabel.text == nil){
           ageLabel.text = "2"
        }
        
        if (genderLabel.text == nil){
           genderLabel.text = "female"
        }
       
        let updateMyNewDog = Dog(dogID: dogID, name: nameLabel.text!, breed: breed, birthDate: Date(), age: ageLabel.text!, gender: genderLabel.text!, vaccination: Date(), color: "", description: "", image: "")
        Functionalities.myUser?.updateDog(dog: updateMyNewDog)

        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    
    
    /* layout constriants for profile image */
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 100).isActive = true
    }
    
    
    var profileImgContainer: UIImageView = {
        let ImgView = UIImageView()
        let Img = UIImage(named: "BlackEmptyDog")
        ImgView.image = Img
        ImgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ImgView.translatesAutoresizingMaskIntoConstraints = false
        
        return ImgView
    }()

    
    
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
        
        if let chosenImage = chosenImageFromPicker{
            profileImgContainer.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
