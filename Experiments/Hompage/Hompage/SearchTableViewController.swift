//
//  SearchTableViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/8/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating{
    
    
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var breeds = [Breed]()
    var filteredBreeds = [Breed]()
    var resultSearchController = UISearchController()
    
    // MARK: - View Setup
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //tableView.estimatedRowHeight = YourTableViewHeight
        tableView.rowHeight = 100.0
        
        // Set up the search controller
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
        
        // Setup the Breeds
        breeds = [
            Breed(breedName: "Yorkshire", personality: "Affectionate, Sprightly, Tomboyish", origin: "", group: "Toy", weight: "", height: "", head: "", body: "", ears: "", hair: "Long", tail: "", shedding: "", grooming:"" , trainability: "5/5", energyLevel: "High", barkingLevel: "", lifeExpectancy: "13-16 years", description: "Yorkies are easily adaptable to all surroundings, travel well and make suitable pets for many homes. Due to their small size, they require limited exercise, but need daily interaction with their people. Their long coat requires regular brushing.", history: "", breeders: "Breeder #1 Jenny, Breeder #2 Ben", image: "http://theyorkietimes.com/wp-content/uploads/2013/02/file7291304821519.jpg"),
            Breed(breedName: "Pug", personality: "Loving, Charming, Mischievous", origin: "", group: "Toy", weight: "", height: "", head: "", body: "", ears: "", hair: "", tail: "", shedding: "", grooming: "", trainability: "3/5", energyLevel: "Medium", barkingLevel: "", lifeExpectancy: "12-15 years", description: "The Pug is a sociable dog that is more apt to sit in a lap than to play. These dogs are remarkably affectionate and they get along well with other animals as well as children. They can, however, become jealous. These little dogs are fairly easy to train and offer a stable temperament that makes them excellent companion animals.", history: "", breeders: "Breeder #1", image: "http://www.dogs-and-dog-advice.com/image-files/pug.jpg")
            
        ]
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text
        NSLog("searchText - \(searchText)")
        self.filteredBreeds.removeAll(keepingCapacity: false)
        filterContentForSearchText(searchText!)
    }
    /*
     * This function filters the result using characters in dog name
     */
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredBreeds = breeds.filter({( breed : Breed) -> Bool in
            return breed.breedName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
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

    /*
     * This function count the number of item to be displayed for search result
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.resultSearchController.isActive && self.resultSearchController.searchBar.text != "" {
            return filteredBreeds.count
        }
        return breeds.count
    }

    /*
     * This function apply array Breed data to be displayed in each table cell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell?
        let mainImageView = cell?.viewWithTag(1) as! UIImageView
        let mainDogName = cell?.viewWithTag(2) as! UILabel
        //set image in the cell to be cicle
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2.0
        mainImageView.clipsToBounds = true
        let breed: Breed
        if self.resultSearchController.isActive && self.resultSearchController.searchBar.text != "" {
            breed = filteredBreeds[indexPath.row]
        } else {
            breed = breeds[indexPath.row]
        }
        
        // Link front-end elment Dogname label and ImageView PlaceHolder
        // with back-end variable
        let urlString = breed.getImage();
        let url = URL(string: urlString)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                print("Staring Loading Image")
                mainImageView.image = self.resizeImage(image: UIImage(data: data!)!, targetSize: CGSize.init(width:70,height:70))
                print("Finished Loading Image")
            }
        }

        // Apply breed name to cell
        mainDogName.text = breed.getBreedName()
        
        //alternate cell color
        if(indexPath.row % 2==0){
            //set cell background color to green
            cell?.backgroundColor = UIColor.init(colorLiteralRed: 165/255, green: 195/255, blue: 187/255, alpha: 0.5)
        }else{
            //set cell background color to bage
            cell?.backgroundColor = UIColor.init(colorLiteralRed: 248/255, green: 221/255, blue: 179/255, alpha: 0.5)
        }
        
        //set image in the cell to be cicle
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2.0
        mainImageView.clipsToBounds = true
        
        return cell!
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //override func prepare(sender: Any?) {
        print("Prepare for DetailView Segue")
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let breed: Breed
                
                if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
                    breed = filteredBreeds[indexPath.row]
                } else {
                    breed = breeds[indexPath.row]
                }
                print(breed.getBreedName())
                let controller = segue.destination as! DetailViewController
                controller.detailBreed = breed
                self.present(controller,animated:true, completion:nil)
//                let secondViewController:OwnedDogDetailViewController = OwnedDogDetailViewController()
//                let controller:segue.destination as! DetailViewController
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailCandy = candy
                print(breed.getBreedName()+" in prepare()")
            }
        }
    }
    
}
