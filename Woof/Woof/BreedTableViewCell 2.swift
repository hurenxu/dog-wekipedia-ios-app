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
    let LABEL_OFFSET_X = 220
    let LABEL_OFFSET_Y = 20
    let IMAGE_OFFSET_X = 15
    let IMAGE_OFFSET_Y = 30
    let SCROLL_OFFSET = 65

    var labelString: String! = ""
    var descriptionString: String! = ""
    //name
    let yellow: UIColor = UIColor(red: 225/255, green: 210/255, blue: 161/255, alpha: 0.9)
    //description
    let green_half: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.8)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    //cell backgroup
    let white: UIColor = UIColor(red: 225/255, green: 245/255, blue: 245/255, alpha: 1)

    
    let FONT: String = "Rubik"
    let FONT_MED: String = "Rubik-Medium"

    let TITLE_FONT_SIZE: Int = 17
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
                
                // set up the image
                let IMAGE_SIZE: CGSize = CGSize(width:150, height: 80)
                let IMAGE_ORIGIN: CGPoint = CGPoint(x: IMAGE_OFFSET_X, y: IMAGE_OFFSET_Y)
                
                myImage = UIImageView(frame: CGRect(origin: IMAGE_ORIGIN, size: IMAGE_SIZE))
            }
            
            else if !initialized {
                
                // set up the title label
                let LABEL_SIZE: CGSize = CGSize(width: 220, height: 20)
                let LABEL_ORIGIN: CGPoint = CGPoint(x: contentView.frame.width - CGFloat(LABEL_OFFSET_X), y: CGFloat(LABEL_OFFSET_Y))

                myLabel = UILabel(frame: CGRect(origin: LABEL_ORIGIN, size: LABEL_SIZE))
                setUpLabel(myString: labelString, myFont: FONT_MED, mySize: TITLE_FONT_SIZE, myColor: yellow, myAlignment: NSTextAlignment.center, myCorner: CORNER_RADIUS, myLabel: myLabel)
                myLabel.numberOfLines = 2
                contentView.addSubview(myLabel)
                myImage.setRound()
                
                contentView.addSubview(myImage)

                // set up the scroll view
                let SCROLL_SIZE: CGSize = CGSize(width: 220, height: 120)
                let SCROLL_ORIGIN: CGPoint = CGPoint(x: LABEL_ORIGIN.x, y: LABEL_ORIGIN.y + CGFloat(SCROLL_OFFSET))
                
                myScrollView = UIScrollView(frame: CGRect(origin: SCROLL_ORIGIN, size: SCROLL_SIZE))
                myScrollView.backgroundColor = white
                myScrollView.layer.cornerRadius = CGFloat(2)
                contentView.addSubview(myScrollView)
                
                // set up the description label
                let DESCRIPTION_SIZE: CGSize = CGSize(width: 220, height: 120)
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
                //myImage.image = UIImage(named: imageString)
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
