//
//  DetailViewController.swift
//  Hompage
//
//  Created by Ye Zhao on 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailBreedName: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    var detailBreed: Breed? {
        didSet {
            print((detailBreed?.getBreedName())!+"DetailView Name Passed")
            configureView()
            print("configureView end")
        }
    }
    /*
     * This function configures view for the breed detail page
     */
    func configureView() {
        print("Configure View")
        //detailBreedName.text = detailBreed?.getBreedName()
        if let detailBreed = detailBreed {
            if let detailDescription = detailDescription, let detailImageView = detailImageView, let detailBreedName = detailBreedName
            {
                detailBreedName.text = detailBreed.getBreedName()
                detailDescription.text = detailBreed.getDescription()
                //Get Breed Profile Image URL
                let urlString = detailBreed.getImage();
                let url = URL(string: urlString)
                
                // Load Dog Image from URL
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        print("Staring Loading Image")
                        detailImageView.image = self.resizeImage(image: UIImage(data: data!)!,  targetSize: CGSize.init(width:70,height:70))
                        print("Finished Loading Image")
                    }
                }
                
            }
        }
    }
    
    
    /*
     * This function resizes the image
     */
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
//        detailImageView.layer.borderWidth = 1
//        detailImageView.layer.masksToBounds = false
//        detailImageView.layer.borderColor = UIColor.init(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.5).cgColor
//        detailImageView.layer.cornerRadius = detailImageView.frame.height/2
//        detailImageView.clipsToBounds = true
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


