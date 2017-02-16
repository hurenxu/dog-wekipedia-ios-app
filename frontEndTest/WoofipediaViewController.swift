//
//  WoofipediaViewController.swift
//  cellTest
//
//  Created by Meiyi He on 2/12/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit


class WoofipediaViewController: UITableViewController, UISearchResultsUpdating  {
    
    
    var dogs = ["Yorkshire", "Pug","Siberian Husky","Beagle","Bulldog","Poodle","Boxer","Chihuahua","Pit bull","Akita","Pomeranian"]
    var filteredDogs = [String]()
    var resultSearchController = UISearchController()
    
    var selectedRow = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        print(dogs.count)
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        //view.addSubview(resultSearchController.searchBar)
        
        self.definesPresentationContext = true
        
        
        self.tableView.reloadData()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive {
            return self.filteredDogs.count
        } else {
            return self.dogs.count
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cell.textLabel?.text = dogs[indexPath.row]
        
        if self.resultSearchController.isActive{
            cell.textLabel?.text = self.filteredDogs[indexPath.row]
        } else {
            cell.textLabel?.text = self.dogs[indexPath.row]
            
        }
        // Configure the cell...
        
        
        let dogName = dogs[indexPath.row]
        
        
        cell.textLabel?.text = dogName
        
        cell.detailTextLabel?.text = "click to view more"
        cell.detailTextLabel?.textColor = UIColor.red
        
        if( UIImage(named: dogName) == nil){
            cell.imageView?.image = UIImage(named: "Yorkshire")
        }else{
            cell.imageView?.image = UIImage(named: dogName)
        }
        
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredDogs.removeAll(keepingCapacity: false)
        let serachPredicate = NSPredicate(format: "SELF CONTAINS[c] %@",searchController.searchBar.text!)
        let array = (self.dogs as NSArray).filtered(using: serachPredicate)
        self.filteredDogs = array as! [String]
        self.tableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yourSegue" {
            
            let detailViewController = segue.destination
                as! ProfileViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            detailViewController.receivedData = dogs[myIndexPath.row]
            detailViewController.idx = row
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Woofipedia", image: UIImage(named: "searchTab"), tag: 1)
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
    
}
