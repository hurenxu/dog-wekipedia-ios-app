//
//  DetailViewController.swift
//  Hompage
//
//  Created by Ye Zhao on 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
//    var detailDog: Breed? {
//        didSet {
//            configureView()
//        }
//    }
//    
//    func configureView() {
//        if let detailDog = detailDog {
//            if let detailDescriptionLabel = detailDescriptionLabel, let dogImageView = dogImageView {
//                detailDescriptionLabel.text = detailDog.name
//                dogImageView.image = UIImage(named: detailDog.name)
//
//                
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

