//
//  OwnedDogDetailViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/28/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class OwnedDogDetailViewController: UIViewController, UINavigationBarDelegate  {
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
        
        self.title = "Title"
        
       
       
        
        //let leftButton =  UIBarButtonItem(title: "Left Button", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
       // let rightButton = UIBarButtonItem(title: "Right Button", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
       // navigationItem.leftBarButtonItem = leftButton
       // navigationItem.rightBarButtonItem = rightButton
        
        
        
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OwnedDogDetailViewController.goBack))
        backButton.tintColor = UIColor.blue
        navigationItem.leftBarButtonItem = backButton
        //view.addSubview(backButton)
        
        
    }
    
    func goBack(){
        print("call goBack function")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "iPetViewController") as! iPetViewController
        self.present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
//    func backAction() -> Void {
//        print("bbutton back function")
//        let _ = self.navigationController?.popViewController(animated: true)
//        //self.UINavigationBar?.popViewController(animated: true)
//    }
    
    
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
