//
//  OwnedDogCell.swift
//  frontEndTest
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
        
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 228.0/255.0, blue: 196.0/255.0, alpha: 1)
        //imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        //self.imageView?.layer.cornerRadius = self.imageView!.frame.size.width / 2
        imageView?.setRounded()
        self.imageView?.clipsToBounds = true
        contentView.addSubview(imageView!)
        
        imageView?.isUserInteractionEnabled = true
        
        textLabel = UILabel(frame: CGRect(x: 0, y: (imageView?.frame.size.height)! - 16, width: frame.size.width, height: frame.size.height/2))
        textLabel?.font = UIFont(name: "Rubik", size: 14)
        textLabel?.textAlignment = .center
        //textLabel?.text = "test"
        textLabel?.textColor = UIColor.black
        contentView.addSubview(textLabel!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
