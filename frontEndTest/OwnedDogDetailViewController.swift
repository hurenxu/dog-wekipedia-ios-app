//
//  OwnedDogDetailViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/28/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class OwnedDogDetailViewController: UIViewController {
    var name = ""
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        print(name)
        // Do any additional setup after loading the view.
        
        self.title = "My Dog"
        
        
        let nameLabel = UILabel(frame: CGRect(x: 200, y: 250, width: 200, height: 200))
        nameLabel.center = CGPoint(x: 180, y: 250)
        nameLabel.textAlignment = .center
        
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = nameLabel.font.withSize(30)
        view.addSubview(nameLabel)
        
        
        let genderLabel = UILabel(frame: CGRect(x: 200, y: 250, width: 200, height: 200))
        genderLabel.center = CGPoint(x: 180, y: 300)
        genderLabel.textAlignment = .center
        
        genderLabel.text = gender
        genderLabel.textColor = UIColor.black
        genderLabel.font = genderLabel.font.withSize(30)
        view.addSubview(genderLabel)
        
        
        /* user profile image */
        let dogImg = profileImgContainer(string:name)
        dogImg.setRounded()
        self.view.addSubview(dogImg)
        ImageViewConstraints(Img: dogImg)
        
        //let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
//        self.view.addSubview(navBar);
//        let navItem = UINavigationItem(title: "SomeTitle");
//
//        navBar.setItems([navItem], animated: false);
        
//        let backbutton = UIButton(type: .custom)
//        backbutton.setImage(UIImage(named: "Dog-50"), for: .normal) // Image can be downloaded from here below link
//        backbutton.setTitle("Back", for: .normal)
//        
//        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
//        backbutton.addTarget(self, action: #selector(OwnedDogDetailViewController.backAction), for: .touchUpInside)
//        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
//        self.view.addSubview(backbutton)
        

    }
    
    func backAction() -> Void {
        print("bbutton back function")
        let _ = self.navigationController?.popViewController(animated: true)
        //self.UINavigationBar?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* global variable: profileImgContainer --> default profile image */
    func profileImgContainer(string: String) -> UIImageView{
        let ImgView = UIImageView()
        let Img = UIImage(named: string)
        ImgView.image = Img
        ImgView.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        ImgView.translatesAutoresizingMaskIntoConstraints = false
        
        return ImgView
    }
    
    /* layout constriants for profile image */
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 100).isActive = true
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
