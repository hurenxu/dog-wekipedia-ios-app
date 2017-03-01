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
        self.view.backgroundColor = UIColor.orange
        
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
        
//        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OwnedDogDetailViewController.goBack))
//        backButton.tintColor = UIColor.blue
//        navigationItem.leftBarButtonItem = backButton
        
        //self.view.addSubview(backButton)
        
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:44)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Title"
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.blue
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        self.view.addSubview(navigationBar)

    }
    
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
