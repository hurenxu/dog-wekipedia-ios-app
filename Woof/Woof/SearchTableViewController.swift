//
//  SearchTableViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/8/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var dogs = [Breed]()
    var filteredDogs = [Breed]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        //self
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        let tools = Functionalities()
        print(tools.getBreedList(controller:self))
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell?
        let mainImageView = cell?.viewWithTag(1) as! UIImageView
        let mainDogName = cell?.viewWithTag(2) as! UILabel
        let mainDogGroup = cell?.viewWithTag(3) as! UILabel
        let breed: Breed
        
        if self.resultSearchController.isActive && self.resultSearchController.searchBar.text != "" {
            breed = filteredDogs[indexPath.row]
        } else {
            breed = dogs[indexPath.row]
        }
        //load URL image
        let urlString = breed.getImage()
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
                    mainImageView.image = UIImage(data: data!)
                }
                }.resume()
        }else { mainImageView.image = #imageLiteral(resourceName: "dogProfile.png")}
        mainDogName.text = breed.getBreedName()
        mainDogGroup.text = breed.getGroup()
        
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
    
    /* This function count the number of item to be displayed for search result
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.resultSearchController.isActive && self.resultSearchController.searchBar.text != "" {
            return filteredDogs.count
        }
        return dogs.count
    }
    
    /* Filter search result*/
    func updateSearchResults(for searchController: UISearchController)
    {
        
        let searchText = searchController.searchBar.text
        NSLog("searchText - \(searchText)")
        self.filteredDogs.removeAll(keepingCapacity: false)
        filterContentForSearchText(searchText!)
    }
    /*
     * This function filters the result using characters in dog name
     */
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDogs = dogs.filter({( dog : Breed) -> Bool in
            return dog.breedName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //override func prepare(sender: Any?) {
        print("Prepare for DetailView Segue")
        if segue.identifier == "showDetail" {
            
            print("enter indexpath")
            if let indexPath = tableView.indexPathForSelectedRow {
                print(indexPath)
                let breed: Breed
                
                if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
                    breed = filteredDogs[indexPath.row]
                } else {
                    breed = dogs[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailDog = breed
            }
        }
    }
}
