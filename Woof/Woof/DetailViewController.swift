//
//  DetailViewController.swift
//  Hompage
//
//  Created by Ye Zhao on 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//
import UIKit
import DOFavoriteButton

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate{
    
    // MARK: - Outlet from UI
    @IBOutlet weak var detailBreedName: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var button: DOFavoriteButton!
    let SCROLL_OFFSET = 0
    var scrollView = UIScrollView(frame: CGRect(x:0, y:410, width:400, height:200))
    let likedArray = Functionalities.myUser?.favoriteDogBreeds
    var table: UITableView! = nil
    let result_origin = CGPoint(x:12, y:40)
    
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
        
        //add tableview for testing
        table = UITableView(frame: CGRect(origin: result_origin, size: CGSize(width: 353, height: self.view.frame.height-12)))
        setUpTable(myColor: UIColor.white, myTable: table)
        
        table.delegate = self
        table.dataSource = self
        
        //view
        super.viewDidLoad()
        
        let width = (self.view.frame.width - 100)
        var x = width / 2
        let y = self.view.frame.height / 2
        
        // heart button
        
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
        x += width
        
//        add labels to the scroll view
        let labelPersonality = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 21))
        labelPersonality.lineBreakMode = NSLineBreakMode.byWordWrapping
        labelPersonality.numberOfLines = 0
        if detailDog != nil {
            labelPersonality.text =
                "Personality: " + "\t" + ((detailDog?.getPersonality())!) + "\n" + "Size: " + "\t" + ((detailDog?.getSize())!)
//             + "\n" + "Group: " + "\t" + (detailDog?.getGroup())!) + "\n" + "Life Expectancy: " + "\t" + ((detailDog?.getLifeExpectancy)!) + "\n" + "Origin: " + "\t" + ((detailDog?.getOrigin())!) + "\n" + "Trainability: " + "\t" + ((detailDog?.getTrainability())!) + "\n" + "Gromming: " + "\t" + ((detailDog?.getGrooming())!) + "\n" + "Shredding: " + "\t" + ((detailDog?.getShredding)!) + "\n"
        }
////            labelSize.text = (detailDog?.getSize())!
////            labelGroup.text = (detailDog?.getGroup())!
////            lifeExpectancy.text = (detailDog?.getLifeExpectancy())!
////            labelOrigin.text = (detailDog?.getOrigin())!
////            labelTrainability.text = (detailDog?.getTrainability())!
//            labelGromming.text = (detailDog?.getGrooming())!
        
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        self.view.addSubview(scrollView)
        scrollView.addSubview(labelPersonality)
        table = UITableView(frame: CGRect(origin: result_origin, size: CGSize(width: 353, height: self.view.frame.height-12)))
        setUpTable(myColor: UIColor.white, myTable: table)
        
        table.delegate = self
        table.dataSource = self
        
        
        
        
        configureView()
        
    }
    
    
    func setUpTable(myColor: UIColor, myTable: UITableView) {
        
        myTable.backgroundColor = myColor
        myTable.layer.cornerRadius = CGFloat(10)
        myTable.rowHeight = CGFloat(80)
        //myTable.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
        print("myTable")
//        scrollView.addSubview(myTable)
        myTable.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print(testArray.count)
        return likedArray!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = likedArray?[indexPath.row]
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}


