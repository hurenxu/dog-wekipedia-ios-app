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
    let cellID = "dogCell"
    //var collectView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        editProfButton.backgroundColor = .black
        editProfButton.setTitle("click here", for: .normal)
        self.view.addSubview(editProfButton)
        EditProfileImageButtonConstraints(Button: editProfButton)
        
        
        
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 250))
        label.center = CGPoint(x: 180, y: 250)
        label.textAlignment = .center
        label.text = "Profile"
        
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        self.view.addSubview(label)
        
        
        //let collectView = UICollectionView()
        let cLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectView = UICollectionView(frame: CGRect(x: 0, y:300, width:view.frame.width, height: view.frame.height/2), collectionViewLayout: cLayout)
        
        cLayout.sectionInset = UIEdgeInsets(top: 25, left:25, bottom:25, right:25)
        cLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height/2)
        

        collectView.dataSource = self
        collectView.delegate = self
        collectView.register( UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        //collectView.showsVerticalScrollIndicator = true
        collectView.backgroundColor = UIColor.black
        
        self.view.addSubview(collectView)
        collectView.reloadData()
        collectView.collectionViewLayout.invalidateLayout()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear()
//        self.collectionView.reloadData()
//    }
    
    
//        let testImg = UIImageView()
//        testImg.image = UIImage(named: "OrangeFilledDog")
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height/2 ))
//        scrollView.backgroundColor = UIColor.black
//        scrollView.addSubview(testImg)
//        self.view.addSubview(scrollView)
//        scrollViewConstraints(Scroller: scrollView)
    


    
//    func profileImg(name:String) -> UIImageView{
//        let dogImg = UIImageView()
//        
//        if(UIImage(named:name)?.size == nil){
//            dogImg.image = UIImage(named:"Yorkshire")
//        }else{
//            dogImg.image = UIImage(named:name)
//        }
//        
//        dogImg.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        dogImg.translatesAutoresizingMaskIntoConstraints = false
//        //You need to call this property so the image is added to your view
//        return dogImg
//    }
 
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        //collectionView.reloadData()
        
        cell.backgroundColor = UIColor.orange
        //print("return cell ....\(i = i+1)")
        let cLabel = UILabel(frame: CGRect(x: 5, y: 5, width: cell.frame.width, height: 50))
        cLabel.textAlignment = .left
        cLabel.text = ownedDog[indexPath.row]
        cLabel.textColor = UIColor.black
        cell.addSubview(cLabel)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("didEndDisplayingCell")
//        var i:Int = 0
//        for( i < indexPath.row){
//                cell.prepareForReuse()
//            i+=1
//        }
//        
//        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        print("transitionLayoutForOldLayout")
        let transitionLayout = UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        transitionLayout.transitionProgress = 1.5
        return transitionLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell number ", indexPath.row)
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
    
//    func scrollViewConstraints(Scroller: UIScrollView){
//        Scroller.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/2).isActive = true
//        Scroller.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        Scroller.translatesAutoresizingMaskIntoConstraints = false
//        print("should have the scroll view controller ?")
//    }
//-----------------------------------------------------------------------------------------------------------
    
    
    
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

/* present a circular profile image */
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

