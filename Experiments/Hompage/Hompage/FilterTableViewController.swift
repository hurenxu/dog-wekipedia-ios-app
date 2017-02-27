//
//  FilterTableViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17  Updated by Ye Zhao 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, UISearchResultsUpdating ,UISearchBarDelegate{
    
    //stay in the same view
    let searchController = UISearchController(searchResultsController: nil)
    
    //populate dog list with tags
    
    var dogs = [
        Dog(name:"Yorkshire", size:"small", hair:"long hair"),
        Dog(name:"Pug", size:"small", hair:"short hair"),
        Dog(name:"Siberian Husky", size:"small", hair:"long hair"),
        Dog(name:"Beagle", size:"small", hair:"short hair"),
        Dog(name:"Poodle", size:"large", hair:"long hair"),
        Dog(name:"Boxer", size:"small", hair:"short hair"),
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        //add some parameters
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["small", "large", "long hair", "short hair"]
        searchController.searchBar.delegate = self
        
        
        //copied
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    var filteredDogs = [Dog]()
    
    func filterSmallContentForSearchText(scope: String = "small"){
        filteredDogs = dogs.filter { Dog in
            let categoryMatch = (scope == "small") || (Dog.size == scope)
            return categoryMatch
        }
        tableView.reloadData()
    }
    func filterLargeContentForSearchText(scope: String = "large"){
        filteredDogs = dogs.filter { Dog in
            let categoryMatch = (scope == "large") || (Dog.size == scope)
            return categoryMatch
        }
        tableView.reloadData()
    }
    func filterLongHairContentForSearchText(scope: String = "long hair"){
        filteredDogs = dogs.filter { Dog in
            let categoryMatch = (scope == "long hair") || (Dog.size == scope)
            return categoryMatch
        }
        tableView.reloadData()
    }
    func filterShortHairContentForSearchText(scope: String = "short hair"){
        filteredDogs = dogs.filter { Dog in
            let categoryMatch = (scope == "short hair") || (Dog.size == scope)
            return categoryMatch
        }
        tableView.reloadData()
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
        if self.searchController.isActive {
            return self.filteredDogs.count
        } else {
            return self.dogs.count
        }    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        
        let newDog: Dog
        if searchController.isActive && searchController.searchBar.text != "" {
            newDog = filteredDogs[indexPath.row]
        }else{
            newDog = dogs[indexPath.row]
        }
        cell.detailTextLabel?.text = newDog.hair
        cell.detailTextLabel?.text = newDog.size
        

        return cell
    }
    
    
    //copied
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    var detailViewController: DetailViewController? = nil

    // MARK: - Segues
    //override
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let newDog: Dog
                if searchController.isActive && searchController.searchBar.text != "" {
                    newDog = filteredDogs[indexPath.row]
                }else{
                    newDog = dogs[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailDog = newDog
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSmallContentForSearchText(scope: searchBar.scopeButtonTitles![selectedScope])
        filterLargeContentForSearchText(scope: searchBar.scopeButtonTitles![selectedScope])
        filterShortHairContentForSearchText(scope: searchBar.scopeButtonTitles![selectedScope])
        filterLongHairContentForSearchText(scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func updateSearchResults(for searchTableViewController: UISearchController){
    //func updateSearchResultsForSearchController(searchController: UISearchController) {
        //filterSmallContentForSearchText(searchText: searchController.searchBar.text!)
        let searchBar = searchTableViewController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterSmallContentForSearchText(scope: scope)
        filterLargeContentForSearchText(scope: scope)
        filterShortHairContentForSearchText(scope: scope)
        filterLongHairContentForSearchText(scope: scope)
    }

}

