//
//  ColumnCell.swift
//  Woof
//
//  Created by Joann Chen on 3/12/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import Foundation
import UIKit

class ColumnCell: UITableViewCell {
    
    @IBOutlet weak var column1: UILabel!
    @IBOutlet weak var column2: UILabel!
    var initialized: Bool = false
    var first: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("Hello nib")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        print("cell setSelected")
        print(selected)
        if !selected {
            if first {
                first = false
                print("enter initialized")
                initialized = true
//                column1.numberOfLines = 0
//                column2.numberOfLines = 0
//                column2.sizeToFit()
//                column2.lineBreakMode = .byWordWrapping
            }
            else if !initialized {
            }
        }
    }

    
    
    
}
