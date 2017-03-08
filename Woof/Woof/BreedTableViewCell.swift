//
//  BreedTableViewCell.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 3/4/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    let CORNER_RADIUS: Int = 20
    
    // the offsets
    let LABEL_OFFSET_X = 170
    let LABEL_OFFSET_Y = 20
    let IMAGE_OFFSET_X = 15
    let IMAGE_OFFSET_Y = 30
    let SCROLL_OFFSET = 65

    var labelString: String! = ""
    var imageString: String! = "Dachshund"
    var descriptionString: String! = ""
    
    let TITLE_COLOR: UIColor = UIColor(red: 253.0/255.0, green: 127.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    let SCROLL_COLOR: UIColor = UIColor(red: 111.0/255.0, green: 135.0/255.0, blue: 143.0/255.0, alpha: 1.0)
    
    let FONT: String = "Noteworthy"
    let TITLE_FONT_SIZE: Int = 20
    let DESCRIPTION_FONT_SIZE: Int = 15
    let NUM_LINES: Int = 100
    
    var initialized: Bool = false
    var first: Bool = true
    
    var myLabel: UILabel! = nil
    var myImage: UIImageView! = nil
    var myScrollView: UIScrollView! = nil
    var myDescription: UILabel! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("hello nib")
    }
    
    func setUpLabel(myString: String, myFont: String, mySize: Int, myColor: UIColor, myAlignment: NSTextAlignment, myCorner: Int, myLabel: UILabel) {
        
        myLabel.text = myString
        myLabel.font = UIFont(name: FONT, size: CGFloat(mySize))
        myLabel.clipsToBounds = true
        myLabel.textColor = UIColor.black
        myLabel.backgroundColor = myColor
        myLabel.textAlignment = myAlignment
        myLabel.layer.cornerRadius = CGFloat(myCorner)
        myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        // 这行有毒
        // super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
        
        if !selected {
            
            if first {
                
                // skip the first time
                first = false
            }
            
            else if !initialized {
                
                // set up the title label
                let LABEL_SIZE: CGSize = CGSize(width: 160, height: 60)
                let LABEL_ORIGIN: CGPoint = CGPoint(x: contentView.frame.width - CGFloat(LABEL_OFFSET_X), y: CGFloat(LABEL_OFFSET_Y))

                myLabel = UILabel(frame: CGRect(origin: LABEL_ORIGIN, size: LABEL_SIZE))
                setUpLabel(myString: labelString, myFont: FONT, mySize: TITLE_FONT_SIZE, myColor: TITLE_COLOR, myAlignment: NSTextAlignment.center, myCorner: CORNER_RADIUS, myLabel: myLabel)
                myLabel.numberOfLines = 2
                contentView.addSubview(myLabel)
                
                // set up the image
                let IMAGE_SIZE: CGSize = CGSize(width: 140, height: 140)
                let IMAGE_ORIGIN: CGPoint = CGPoint(x: IMAGE_OFFSET_X, y: IMAGE_OFFSET_Y)
                
                myImage = UIImageView(frame: CGRect(origin: IMAGE_ORIGIN, size: IMAGE_SIZE))
                myImage.image = UIImage(named: imageString)
                myImage.setRound()
                contentView.addSubview(myImage)

                // set up the scroll view
                let SCROLL_SIZE: CGSize = CGSize(width: 160, height: 80)
                let SCROLL_ORIGIN: CGPoint = CGPoint(x: LABEL_ORIGIN.x, y: LABEL_ORIGIN.y + CGFloat(SCROLL_OFFSET))
                
                myScrollView = UIScrollView(frame: CGRect(origin: SCROLL_ORIGIN, size: SCROLL_SIZE))
                myScrollView.backgroundColor = SCROLL_COLOR
                myScrollView.layer.cornerRadius = CGFloat(CORNER_RADIUS)
                contentView.addSubview(myScrollView)
                
                // set up the description label
                let DESCRIPTION_SIZE: CGSize = CGSize(width: 150, height: 10)
                let DESCRIPTION_ORIGIN: CGPoint = CGPoint(x: 10, y: 0)
                myDescription = UILabel(frame: CGRect(origin: DESCRIPTION_ORIGIN, size: DESCRIPTION_SIZE))
                setUpLabel(myString: descriptionString, myFont: FONT, mySize: DESCRIPTION_FONT_SIZE, myColor: UIColor.clear, myAlignment: NSTextAlignment.left, myCorner: 0, myLabel: myDescription)
                myDescription.numberOfLines = NUM_LINES
                myDescription.sizeToFit()
                
                // add the description label to the scroll view
                myScrollView.addSubview(myDescription)
                myScrollView.contentSize.height = myDescription.frame.height
                
                initialized = true
            }
            
            else {

                myLabel.text = labelString
                myDescription.text = descriptionString
                myImage.image = UIImage(named: imageString)
            }
        }
    }
}


// round the image
extension UIImageView {
    
    func setRound() {
    
        let RADIUS = self.frame.width / 2
        self.layer.cornerRadius = RADIUS
        self.layer.masksToBounds = true
    }
}
