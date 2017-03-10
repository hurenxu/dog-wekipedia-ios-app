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
    
    
    var ownedDog = [String]()
    
    var breed = [String]()
    
    var age = [String]()
    
    var gender = [String]()
    
    var color = [String]()
    
    //test added
    var dogList: [Dog] = []
    
    //var ownedDog: [Dog] = []
    
    var collectView: UICollectionView!
    
    var cLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //test added end
    
    var user:User?
    
    
    
     let editProfButton:UIButton = UIButton(frame: CGRect(x: 155, y: 220, width: 60, height: 20))
     let notificationButton:UIButton = UIButton(frame: CGRect(x:330, y: 70, width: 40, height:40))
     let addDogProfileButton:UIButton = UIButton(frame: CGRect(x:330, y: 250, width: 40, height:40))
    
    
    
    let cellID = "dogCell"
    //var collectView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // let image = UIImage(named:"bacgroundHome.png")
        let shade = UIImageView(frame:UIScreen.main.bounds)
        shade.backgroundColor = UIColor.black
        shade.alpha = 0.5
        self.view.addSubview(shade)
        self.view.sendSubview(toBack: shade)
        
        let imageName = "backgroundHome.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 65, width: 375, height: 240)
        view.addSubview(imageView)

        
        
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        
        
        self.view.backgroundColor = .white

        self.title = "User Profile"
        //print("iPet Page loaded")
        //self.view.backgroundColor = UIColor.lightGray
        
        
        /* user profile image */
        let userImg = profileImgContainer
        userImg.setRounded()
        self.view.addSubview(userImg)
        ImageViewConstraints(Img: userImg)
        
        
       
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
        
        
        
       

        notificationButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        notificationButton.setTitle("No!", for: .normal)
        notificationButton.setTitleColor(.black, for: .normal)
        notificationButton.layer.cornerRadius = 20
        notificationButton.clipsToBounds = true
        notificationButton.addTarget(self, action: #selector(self.transition(_:)), for: .touchUpInside)
        self.view.addSubview(notificationButton)
        
        
        
        addDogProfileButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        addDogProfileButton.setTitle("Add", for: .normal)
        addDogProfileButton.setTitleColor(.black, for: .normal)
        addDogProfileButton.layer.cornerRadius = 20
        addDogProfileButton.clipsToBounds = true
        addDogProfileButton.addTarget(self, action: #selector(addDogProfileButtonClick), for: .touchUpInside)
        self.view.addSubview(addDogProfileButton)

    

        
        //let controller:LoginViewController = LoginViewController()
        
        //self.user = controller.user
        
        //print(self.user?.name)
        
        //add data from firebase
        
        //test use and add a real user later
        let tools = Functionalities()
        let user = Functionalities.myUser
        
        if (!Functionalities.userExist) {
            user?.addUserProfileEntry()
            print("new user profile added @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        }
        
        //print("look here @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        //print(Functionalities.myUser?.dogIDs.count)
        print(tools.retrieveDogList(controller:self))
        //add finished
        
        
        
        
   //     let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 250))
    //    label.center = CGPoint(x: 180, y: 270)
   //     label.text = "User Profile"
   //     label.textAlignment = .center
    //    label.textColor = UIColor.white
        
        
   //     label.font = label.font.withSize(30)
   //     self.view.addSubview(label)
        
        
        //let collectView = UICollectionView()
        //let cLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectView = UICollectionView(frame: CGRect(x: 0, y:300, width:view.frame.width, height: view.frame.height/2), collectionViewLayout: cLayout)
        
        
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
        Button.topAnchor.constraint(equalTo: view.topAnchor, constant:223.0).isActive = true
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
    
    func addDogProfileButtonClick(sender: UIButton)
    {
        let secondViewController:AddDogViewController = AddDogViewController()
        
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    
    
    
    
    /* tab bar controller: 3rd position */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "ipet", image: UIImage(named: "ipet"), tag: 1)
        tabBarItem.badgeValue = "3"
    }
    
}



