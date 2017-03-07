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
