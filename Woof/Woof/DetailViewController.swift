//
//  DetailViewController.swift
//  Hompage
//
//  Created by Ye Zhao on 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//
import UIKit
import DOFavoriteButton

class DetailViewController: UIViewController, UINavigationBarDelegate{
    
    // MARK: - Outlet from UI
    @IBOutlet weak var detailBreedName: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var button: DOFavoriteButton!
    let SCROLL_OFFSET = 0
    let LABEL_OFFSET = 20
    var scrollView = UIScrollView(frame: CGRect(x:0, y:410, width:400, height:350))
    let result_origin = CGPoint(x:2, y:40)
    
    // MARK: - Setup data passing variable matches the SearchTableViewController.swift class's prepare function
    
    var detailDog: Breed? {
        didSet {
            print("Call configure view in setting dog value")
            configureView()
            print("finished calling configure view")
        }
    }
    /*
     * This function configures view for the breed detail page
     */
    func configureView() {
        // Check if detailDog is valid
        if let detailDog = detailDog {
            if let detailImageView = detailImageView, let detailBreedName = detailBreedName
            {
                // Assign breed name to the textLabel references in UI
                detailBreedName.text = detailDog.getBreedName()
                detailBreedName.adjustsFontSizeToFitWidth = true
                
                //Get Breed Profile Image URL
                let urlString = detailDog.getImage();
                if let url = URL(string: urlString){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                            print("Failed fetching image:", error ?? "")
                            return
                        }
                        
                        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                            print("Not a proper HTTPURLResponse or statusCode")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            //resize image to have circle border, assign loaded URL image to references in UI
                            detailImageView.image = UIImage(data: data!)
                            detailImageView.layer.cornerRadius = detailImageView.frame.size.width/2.0
                            detailImageView.clipsToBounds = true
                        }
                        }.resume()
                }else {
                    //resize image to have circle border, assign loaded URL image to references in UI
                    detailImageView.image = #imageLiteral(resourceName: "dogProfile.png")
                    detailImageView.layer.cornerRadius = detailImageView.frame.size.width/2.0
                    detailImageView.clipsToBounds = true}
                
            }
        }
    }
    func tappedButton(sender: DOFavoriteButton) {
        if sender.isSelected {
            // deselect
            sender.deselect()
            if Functionalities.myUser != nil{
                Functionalities.myUser?.removeFavoriteDogBreed(breedname:(detailDog?.getBreedName())!)
                Functionalities.myUser?.updateUser()
                print("Successfully removed breed from user favorite")
                //print()
            }
        } else {
            // select with animation
            sender.select()
            if Functionalities.myUser != nil{
                Functionalities.myUser?.addFavoriteDogBreed(breedname:(detailDog?.getBreedName())!)
                Functionalities.myUser?.updateUser()
                print("Successfully added breed to user favorite")
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        //view
        super.viewDidLoad()
        
        let width = (self.view.frame.width - 100)
        var x = width / 2
        let y = self.view.frame.height / 2
        
        // add heart button
        let button = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 100, height: 100), image: UIImage(named: "like"))
        button.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        button.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        button.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        if Functionalities.myUser != nil{
            if (Functionalities.myUser?.breedIsLiked(breedname:(detailDog?.getBreedName())!))! {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        self.view.addSubview(button)
        
        // add scroll view
        self.view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        scrollView.backgroundColor = UIColor.clear
    
        // add labels to the scroll view
        var firstLabely = 0
        let labelPersonality = UILabel(frame: CGRect(x: 20, y: 0, width: Int(scrollView.frame.width-50), height: 50))
        labelPersonality.text = "PERSONALITY: " + ((detailDog?.getPersonality())!)
        firstLabely = firstLabely + Int(heightForView(label: labelPersonality)) + LABEL_OFFSET
        let labelSize = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelSize.text = "SIZE: " + ((detailDog?.getSize())!)
        firstLabely = firstLabely + Int(heightForView(label: labelSize)) + LABEL_OFFSET
        let labelGroup = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelGroup.text = "GROUP: " + ((detailDog?.getGroup())!)
        firstLabely = firstLabely + Int(heightForView(label: labelGroup)) + LABEL_OFFSET
        let labelType = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelType.text = "TYPE: " + ((detailDog?.getType())!)
        firstLabely = firstLabely + Int(heightForView(label: labelType)) + LABEL_OFFSET
        let labelLifeExpectancy = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelLifeExpectancy.text = "LIFE EXPECTANCY: " + ((detailDog?.getLifeExpectancy())!)
        firstLabely = firstLabely + Int(heightForView(label: labelLifeExpectancy)) + LABEL_OFFSET
        let labelOrigin = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelOrigin.text = "ORIGIN: " + ((detailDog?.getOrigin())!)
        firstLabely = firstLabely + Int(heightForView(label: labelOrigin)) + LABEL_OFFSET
        let labelTrainability = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelTrainability.text = "TRAINABILITY: " + ((detailDog?.getTrainability())!)
        firstLabely = firstLabely + Int(heightForView(label: labelTrainability)) + LABEL_OFFSET
        let labelGrooming = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelGrooming.text = "GROOMING: " + ((detailDog?.getGrooming())!)
        firstLabely = firstLabely + Int(heightForView(label: labelGrooming)) + LABEL_OFFSET
        let labelShedding = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelShedding.text = "SHEDDING: " + ((detailDog?.getShedding())!)
        firstLabely = firstLabely + Int(heightForView(label: labelShedding)) + LABEL_OFFSET
        let labelBarkingLevel = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelBarkingLevel.text = "BARKING LEVEL: " + ((detailDog?.getBarkingLevel())!)
        firstLabely = firstLabely + Int(heightForView(label: labelBarkingLevel)) + LABEL_OFFSET
        let labelPrice = UILabel(frame: CGRect(x: 20, y: firstLabely, width: Int(scrollView.frame.width-50), height: 50))
        labelPrice.text = "PRICE: " + ((detailDog?.getPrice())!)
        firstLabely = firstLabely + Int(heightForView(label: labelPrice)) + LABEL_OFFSET
        configureView()
        
    }
    /* This function is to set label format */
    func heightForView(label:UILabel) -> CGFloat{
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.layer.cornerRadius = 8
        label.backgroundColor = UIColor(netHex: 0xa5c3bb)
        label.layer.masksToBounds = true
        label.sizeToFit()
        label.frame = CGRect(origin: label.frame.origin, size: CGSize(width: scrollView.frame.width-80, height: label.frame.height))
        scrollView.addSubview(label)
        return label.frame.height
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width:375, height:1000)
    }
    


    
}


