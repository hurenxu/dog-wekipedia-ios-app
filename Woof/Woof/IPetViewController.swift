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
    
    
//    var ownedDog = [String]()
//    
//    var breed = [String]()
//    
//    var age = [String]()
//    
//    var gender = [String]()
//    
//    var color = [String]()
//    
//    var dogID = [String]()
//    
//    var dogList: [Dog] = []
    
    var dogImages = [String: UIImage]()
    
    var collectView: UICollectionView!
    
    var cLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var user:User?
    
    var userImg: UIImageView! = nil
    
     let editProfButton:UIButton = UIButton(frame: CGRect(x: 155, y: 220, width: 60, height: 20))
     let notificationButton:UIButton = UIButton(frame: CGRect(x:330, y: 70, width: 40, height:40))
     let addDogProfileButton:UIButton = UIButton(frame: CGRect(x:330, y: 250, width: 40, height:40))
    
    
    
    let cellID = "dogCell"
    //var collectView = UICollectionView()
        
    func switchToUser(sender: UIButton) {
        
        print("switch to user")
        
        let userVC: UserViewController! = UserViewController()
        userVC.iPet = self
        
        self.present(userVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (Functionalities.myUser == nil) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            appDelegate.window?.rootViewController? = initViewController
            
            
            let MyrootViewController = appDelegate.window!.rootViewController
            //self.performSegue(withIdentifier: "backtologin", sender: self)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
//                self.performSegue(withIdentifier: "backtologin", sender: self)
//            })
            
            

        }
        else {
        // let image = UIImage(named:"bacgroundHome.png")
        let shade = UIImageView(frame:UIScreen.main.bounds)
        shade.backgroundColor = UIColor.black
        shade.alpha = 0.5
        self.view.addSubview(shade)
        self.view.sendSubview(toBack: shade)
        
        let imageName = "backgroundHome.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 65, width: 380, height: 380)
        view.addSubview(imageView)

        
        
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        
        
//        self.view.backgroundColor = .white
//        //self.title = "iPet"
//        let frame = CGRect(x: 0, y: 0, width: 200, height: 40)
//        let tlabel = UILabel(frame: frame)
//        tlabel.text = self.title
//        tlabel.textColor = UIColor.black
//        tlabel.backgroundColor = UIColor.clear
//        tlabel.adjustsFontSizeToFitWidth = true
//        tlabel.textAlignment = .center
//        self.navigationItem.titleView = tlabel
        //print("iPet Page loaded")
        //self.view.backgroundColor = UIColor.lightGray
        
        
        /* user profile image */
        userImg = profileImgContainer
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
        //editProfButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        //editProfButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToUser(sender:))))
            editProfButton.addTarget(self, action: #selector(self.switchToUser(sender:)), for: UIControlEvents.touchDown)
        
        
       

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
           
        }

        print(tools.retrieveDogList(controller:self))

        //add finished
        
        tools.retrieveUserImage(UIImageView: profileImgContainer)
        
        collectView = UICollectionView(frame: CGRect(x: 0, y:300, width:view.frame.width, height: view.frame.height/2), collectionViewLayout: cLayout)
        
        
        cLayout.sectionInset = UIEdgeInsets(top: 25, left:40, bottom: 40, right:40)
        cLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 2)
        
        
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register( OwnedDogCell.self, forCellWithReuseIdentifier: cellID)
        //collectView.showsVerticalScrollIndicator = true
        collectView.backgroundColor = UIColor(red: 255.0/255.0, green: 228.0/255.0, blue: 196.0/255.0, alpha: 1)
        
        self.view.addSubview(collectView)
        collectView.reloadData()
        collectView.collectionViewLayout.invalidateLayout()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectView.reloadData()
    }
    
    func transition(_ Sender: UIButton!) {
        let secondViewController:NotificationViewController = NotificationViewController()
        
        if Functionalities.dogList.count == 0 {
            
            // create the alert
            let alert = UIAlertController(title: "Dog Needed", message: "Please add a new dog profile to enter the notification page", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            
            self.present(secondViewController, animated: true, completion: nil)
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:120, height:120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Functionalities.dogList.count)
        return Functionalities.dogList.count
    }
    
    var i:Int = 0
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OwnedDogCell
        
        cell.textLabel?.text = Functionalities.dogList[indexPath.row].getName()
        var Img = UIImage(named: "bone")
        
        let dog = Functionalities.dogList[indexPath.row]
        
        let tools = Functionalities()
        tools.retrieveDogImage(UIImageView:(cell.imageView)!, dog:dog, controller: self)


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
        secondViewController.name = Functionalities.dogList[indexPath.row].getName()
        
        
        secondViewController.gender = Functionalities.dogList[indexPath.row].getGender()
        secondViewController.thisDogID = Functionalities.dogList[indexPath.item].getDogID()
        secondViewController.thisDog = Functionalities.dogList[indexPath.item]
        
        
        secondViewController.breed = Functionalities.dogList[indexPath.row].breed.getBreedName()
        
        
        let newdateFormatter = DateFormatter()
        newdateFormatter.dateStyle = .long
        newdateFormatter.timeStyle = .none
        let strVac = newdateFormatter.string(from: (Functionalities.dogList[indexPath.row].getVaccination()))
        secondViewController.vaccinationdate = strVac
        
        let strBir = newdateFormatter.string(from: (Functionalities.dogList[indexPath.row].getBirthDate()))
        secondViewController.birthdate = strBir
        
        secondViewController.age = Functionalities.dogList[indexPath.row].getAge()
        secondViewController.color = Functionalities.dogList[indexPath.row].getColor()
        
        secondViewController.profileImgContainer.image = dogImages[Functionalities.dogList[indexPath.row].dogID]
        
        //print(dogImages[Functionalities.dogList[indexPath.row].dogID])
        //print(dogImages[Functionalities.dogList[indexPath.row].dogID])
        
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    //------------------------------------------ profile image view ---------------------------------------------
    /* global variable: profileImgContainer --> default profile image */
    var profileImgContainer: UIImageView = {
        let ImgView = UIImageView()
        var Img = UIImage(named: "BlackEmptyDog")
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
        //let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    /* imagePickerController & imagePickerControllerDidCancel handle the pop over and dismissal of profile changing */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //picker.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        var chosenImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            chosenImageFromPicker = editedImage
        }
        
        if let chosenImage = chosenImageFromPicker{
            profileImgContainer.image = chosenImage
            
            let tools = Functionalities()
            tools.addUserImage(chosenImage: chosenImage, user: Functionalities.myUser!)
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
        tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ipet"), tag: 1)
        tabBarItem.badgeValue = "3"
    }
}

extension UIImagePickerController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
    }
}





