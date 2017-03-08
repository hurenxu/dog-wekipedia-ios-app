//
//  DetailViewController.swift
//  Hompage
//
//  Created by Ye Zhao on 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController, UINavigationBarDelegate{
    
    // MARK: - Outlet from UI
    @IBOutlet weak var detailBreedName: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    // MARK: - Setup data passing variable matches the SearchTableViewController.swift class's prepare function
    var detailDog: Breed? {
        didSet {
            print((detailDog?.getBreedName())!+"DetailView Name Passed")
//            configureView()
            print("configureView end")
        }
    }
    /*
     * This function configures view for the breed detail page
     */
    func configureView() {
        print("Configure View")
        print(detailDog?.getBreedName())
        if let detailDog = detailDog {
            if let detailImageView = detailImageView, let detailBreedName = detailBreedName
            {
                detailBreedName.text = detailDog.getBreedName()
                
                //Get Breed Profile Image URL
                let urlString = detailDog.getImage();
                if let url = URL(string: urlString){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                            print("Failed fetching image:", error)
                            return
                        }
                        
                        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                            print("Not a proper HTTPURLResponse or statusCode")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            detailImageView.image = UIImage(data: data!)
                            //set image to circle
                            detailImageView.layer.cornerRadius = detailImageView.frame.size.width/2.0
                            detailImageView.clipsToBounds = true
                        }
                        }.resume()
                }else {
                    detailImageView.image = #imageLiteral(resourceName: "dogProfile.png")
                    detailImageView.layer.cornerRadius = detailImageView.frame.size.width/2.0
                    detailImageView.clipsToBounds = true}
                
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
    
    /* function that directs back to the search page when the nav bar back button
     * is clicked
     */
    func goBack(){
        print("call goBack function")
        dismiss(animated:true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0,width:self.view.frame.size.width,height:55))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Breed Detail"
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title:"Back", style:.plain, target:self,action: #selector(goBack))
        backButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem,animated:true)
        
        self.view.addSubview(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


