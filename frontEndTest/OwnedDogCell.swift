//
//  OwnedDogCell.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/28/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class OwnedDogCell: UICollectionViewCell {
    private(set) var imageView : UIImageView?
    private(set) var textLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView?.layer.cornerRadius = self.imageView!.frame.size.width / 2
        self.imageView?.clipsToBounds = true
        contentView.addSubview(imageView!)
        
        imageView?.isUserInteractionEnabled = true
        
        textLabel = UILabel(frame: CGRect(x: 0, y: (imageView?.frame.size.height)!, width: frame.size.width, height: frame.size.height/2))
        textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        textLabel?.textAlignment = .center
        //textLabel?.text = "test"
        textLabel?.textColor = UIColor.black
        contentView.addSubview(textLabel!)
        
        
       // let notificationButton:UIButton = UIButton(frame: CGRect(x:frame.size.width-30, y: 0, width: 30, height:30))
//        
//       let GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NotificationViewController.self))
        
        
        //tapGestureRecognizer.numberOfTapsRequired = 1
       // notificationButton.addGestureRecognizer(tapGestureRecognizer)
        
       // notificationButton.addGestureRecognizer(GestureRecognizer)
        
        // include other button setup here
       // notificationButton.addTarget(self, action: #selector(transition), for: .touchUpInside)
        

      
//        notificationButton.backgroundColor = .black
//        notificationButton.setTitle("No!", for: .normal)
//        
//        NotifiCationButtonConstraints(Button: notificationButton)
//        contentView.addSubview(notificationButton)
        
    }
    
    
//    func transition(Sender: UIButton!) {
//        //let secondViewController:NotificationViewController = NotificationViewController()
//        let t:UIViewController = NotificationViewController()
//        
//        self.present(t, animated: true, completion: nil)
//        
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func NotifiCationButtonConstraints(Button: UIButton){
//        //Button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
//        
//    }
    
}
/* present a circular profile image */
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
