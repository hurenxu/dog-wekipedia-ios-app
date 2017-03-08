//
//  iPetViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/16/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class iPetViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    var ownedDog = ["Yorkshire", "Pug","Siberian Husky","Beagle","Bulldog","Poodle","Boxer","Chihuahua","Pit bull","Akita","Pomeranian"]
    
    var breed = ["breed1", "breed2","breed3","breed4","breed5","breed6","breed7","breed8","breed9","breed10"]
    
    var age = ["1","3", "5", "7","9","11","1","3","5","7", "9"]
    
    var gender = ["boy", "girl", "unknown"]
    
    var color = ["black", "white", "grey"]
    
    let cellID = "dogCell"
    
    //var collectView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(red: 165.0/255.0, green: 195.0/255.0, blue: 187.0/255.0, alpha: 1)

        
        
        //view.backgroundColor = UIColor.black
        self.title = "iPet"
        print("iPet Page loaded")
        //self.view.backgroundColor = UIColor.lightGray
        

        /* user profile image */
        let userImg = profileImgContainer
        userImg.setRounded()
        self.view.addSubview(userImg)
        ImageViewConstraints(Img: userImg) 
        
        
        let editProfButton:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        editProfButton.backgroundColor = UIColor(red: 100.0/255.0, green: 149.0/255.0, blue: 237.0/255.0, alpha: 1)
        editProfButton.setTitle("change image", for: .normal)
        self.view.addSubview(editProfButton)
        EditProfileImageButtonConstraints(Button: editProfButton)
        editProfButton.layer.cornerRadius = 5
        editProfButton.clipsToBounds = true
        
        
        let notificationButton:UIButton = UIButton(frame: CGRect(x:300, y: 30, width: 40, height:40))
        notificationButton.backgroundColor = UIColor(red: 100.0/255.0, green: 149.0/255.0, blue: 237.0/255.0, alpha: 1)
        notificationButton.setTitle("No!", for: .normal)
        //NotifiCationButtonConstraints(Button: notificationButton)
        
       // notificationButton.addTarget(self, action: #selector(transition(Sender:notificationButton)), for: .touchUpInside)
        notificationButton.addTarget(self, action: #selector(self.transition(_:)), for: .touchUpInside)
        //notificationButton.addTarget(self, action: transition, forControlEvents: .touchUpInside)
        //button = answerButton
        self.view.addSubview(notificationButton)
        notificationButton.layer.cornerRadius = 5;
        notificationButton.clipsToBounds = true
        
        
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 250))
        label.center = CGPoint(x: 180, y: 250)
        label.text = "User Profile"
        label.textAlignment = .center
        label.textColor = UIColor.white
        
        
        //label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        self.view.addSubview(label)
        
        
        //let collectView = UICollectionView()
        let cLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectView = UICollectionView(frame: CGRect(x: 0, y:300, width:view.frame.width, height: view.frame.height/2), collectionViewLayout: cLayout)
        
        cLayout.sectionInset = UIEdgeInsets(top: 25, left:25, bottom:25, right:25)
        cLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height/2)
        

        collectView.dataSource = self
        collectView.delegate = self
        collectView.register( OwnedDogCell.self, forCellWithReuseIdentifier: cellID)
        //collectView.showsVerticalScrollIndicator = true
        collectView.backgroundColor = UIColor(red: 255.0/255.0, green: 228.0/255.0, blue: 196.0/255.0, alpha: 1)
        
        
        
        self.view.addSubview(collectView)
        collectView.reloadData()
        collectView.collectionViewLayout.invalidateLayout()
        
        
        
    
    }
    
    func transition(_ Sender: UIButton!) {
        let secondViewController:NotificationViewController = NotificationViewController()

        self.present(secondViewController, animated: true, completion: nil)

    }

    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:150, height:150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(ownedDog.count)
        return ownedDog.count
    }

    var i:Int = 0
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OwnedDogCell
        
        cell.textLabel?.text = ownedDog[indexPath.row]
        cell.imageView?.image = UIImage(named: "bone")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print("didEndDisplayingCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        print("transitionLayoutForOldLayout")
        let transitionLayout = UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        transitionLayout.transitionProgress = 1.5
        return transitionLayout
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell number ", indexPath.row)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        let secondViewController:OwnedDogDetailViewController = OwnedDogDetailViewController()
        secondViewController.name = ownedDog[indexPath.row]
        secondViewController.gender = gender[indexPath.row % 3]
        
          
        self.present(secondViewController, animated: true, completion: nil)
        
        
    }
    
       
    
    
//------------------------------------------ profile image view ---------------------------------------------
    /* global variable: profileImgContainer --> default profile image */
    var profileImgContainer: UIImageView = {
        let ImgView = UIImageView()
        let Img = UIImage(named: "BlackEmptyDog")
        ImgView.image = Img
        ImgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ImgView.translatesAutoresizingMaskIntoConstraints = false
        
        return ImgView
    }()
    
    
//----------------------------------------- layout constraints ----------------------------------------------
    /* layout constriants for profile image */
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 50.0).isActive = true
    }
    
    
    /* profile image changing button's constraint & add target */
    func EditProfileImageButtonConstraints(Button: UIButton){
        Button.topAnchor.constraint(equalTo: view.topAnchor, constant:180.0).isActive = true
        Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        
        /* action when user click on button --> call handleSelectProfileImageView function */
        Button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
    }
        
    
    
//------------------------------------------profile image picker --------------------------------------------
    /* function: add an UIImagePickerController */
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
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
//----------------------------------------------------------------------------------------------------------------

    
    
    
    /* tab bar controller: 3rd position */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "iPet", image: UIImage(named: "iPet"), tag: 1)
        tabBarItem.badgeValue = "3"
    }
    
}



