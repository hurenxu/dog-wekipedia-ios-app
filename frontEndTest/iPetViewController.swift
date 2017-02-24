//
//  iPetViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/16/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class iPetViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //var changeProfile:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //view.backgroundColor = UIColor.black
        self.title = "iPet"
        print("iPet Page loaded")
        
        
//        if( changeProfile == 0 ){
//            let userImg = profileImg(name: "BlackEmptyDog")
//            userImg.setRounded()
//            self.view.addSubview(userImg)
//            ImageViewConstraints(Img: userImg)
//        }else{
//            let userImg = profileImgContainer
//            userImg.setRounded()
//            self.view.addSubview(userImg)
//            ImageViewConstraints(Img: userImg)
//            super.viewDidLoad()
        //}
        
        
        let userImg = profileImgContainer
        userImg.setRounded()
        
        self.view.addSubview(userImg)
        ImageViewConstraints(Img: userImg)
        
        
        let editProfButton:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        editProfButton.backgroundColor = .black
        editProfButton.setTitle("click here", for: .normal)
        view.addSubview(editProfButton)
        EditProfileImageButtonConstraints(Button: editProfButton)
        
        
        
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 250))
        label.center = CGPoint(x: 180, y: 250)
        label.textAlignment = .center
        label.text = "Profile"
        
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        view.addSubview(label)
        
    }
    
    func profileImg(name:String) -> UIImageView{
        let dogImg = UIImageView()
        
        if(UIImage(named:name)?.size == nil){
            dogImg.image = UIImage(named:"Yorkshire")
        }else{
            dogImg.image = UIImage(named:name)
        }
        
        dogImg.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        dogImg.translatesAutoresizingMaskIntoConstraints = false
        //You need to call this property so the image is added to your view
        return dogImg
    }

    
    
    var profileImgContainer: UIImageView = {
        let ImgView = UIImageView()
        let Img = UIImage(named: "BlackEmptyDog")
        
        ImgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ImgView.translatesAutoresizingMaskIntoConstraints = false
        
        return ImgView
    }()
    
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 50.0).isActive = true
    }
    
    
    
    // add constraint to button
    // add a gesture recognizer to button
    func EditProfileImageButtonConstraints(Button: UIButton){
        Button.topAnchor.constraint(equalTo: view.topAnchor, constant:180.0).isActive = true
        Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //Button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
    }
    
    func buttonAction(sender: UIButton!){
        sender.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        //changeProfile = 1
    }
    
    
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var chosenImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            chosenImageFromPicker = editedImage
        }else if let originalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            chosenImageFromPicker = originalImg
        }
        
        
        if let chosenImage = chosenImageFromPicker{
            profileImgContainer.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "iPet", image: UIImage(named: "iPet"), tag: 1)
        tabBarItem.badgeValue = "3"
    }
    
}

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

