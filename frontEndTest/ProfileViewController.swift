//
//  ProfileViewController.swift
//  cellTest
//
//  Created by Meiyi He on 2/12/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var receivedData = ""
    var idx = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(receivedData)
        
        let dogImg = profileImg(name: receivedData)
        
        self.view.addSubview(dogImg)
        dogImageViewConstraints(dogImg: dogImg)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "I'm a test label \(idx)"
        
        
        self.view.addSubview(label)
        
        // Do any additional setup after loading the view.
    }
    
    func profileImg(name:String) -> UIImageView{
        let dogImg = UIImageView()
        
        if(name == ""){
            dogImg.image = UIImage(named:"Yorkshire")
        }else{
            dogImg.image = UIImage(named:name)
        }
        
        dogImg.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        dogImg.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
        return dogImg
    }
    
    func dogImageViewConstraints(dogImg: UIImageView) {
        dogImg.widthAnchor.constraint(equalToConstant: 120).isActive = true
        dogImg.heightAnchor.constraint(equalToConstant: 120).isActive = true
        dogImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        dogImg.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 10.0).isActive = true
        
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
