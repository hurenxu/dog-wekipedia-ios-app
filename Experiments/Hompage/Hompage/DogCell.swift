//
//  DogCell.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class DogCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var userLikeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breederLabel: UILabel!
    @IBOutlet weak var dogFilterLabel: UILabel!

//    var dog: Dog!{
////        didSet {
////            nameLabel.text = dog.name
////            thumbImageView.setImageWithURL(dog.imageURL)
////            dogFilterLabel.text = dog.filters
////            breederLabel.text = "\(dog.breederCount) Breeders" // TODO: dog.breederCount
////            
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        thumbImageView.layer.cornerRadius = 5
//        thumbImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
