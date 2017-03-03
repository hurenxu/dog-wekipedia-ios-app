//
//  SearchTableViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/8/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController{
    
    
//    let dogs = ["Yorkshire", "Pug","Siberian Husky","Beagle","Bulldog","Poodle","Boxer","Chihuahua","Pit bull","Akita","Pomeranian"]
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var breeds = [Breed]()
    
    var filteredDogs = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        //self
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.resultSearchController.isActive {
            return self.filteredDogs.count
        } else {
            return self.dogs.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell?
        let mainImageView = cell?.viewWithTag(1) as! UIImageView
        let mainDogName = cell?.viewWithTag(2) as! UILabel
        mainImageView.image = #imageLiteral(resourceName: "DogImage")
        if self.resultSearchController.isActive{
            //cell!.textLabel?.text = self.filteredDogs[indexPath.row]
            mainDogName.text = self.filteredDogs[indexPath.row]
        } else {
            //cell!.textLabel?.text = self.dogs[indexPath.row]
            mainDogName.text = self.dogs[indexPath.row]
        }
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
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "yourSegue" {
//            
//            let detailViewController = segue.destination
//                as! DogProfile
//            
//            let myIndexPath = self.tableView.indexPathForSelectedRow!
//            let row = myIndexPath.row
//            detailViewController.receivedData = dogs[myIndexPath.row]
//            detailViewController.idx = row
//        }
//    }
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredDogs.removeAll(keepingCapacity: false)
        let serachPredicate = NSPredicate(format: "SELF CONTAINS[c] %@",searchController.searchBar.text!)
        let array = (self.dogs as NSArray).filtered(using: serachPredicate)
        self.filteredDogs = array as! [String]
        self.tableView.reloadData()
    }
    

}
