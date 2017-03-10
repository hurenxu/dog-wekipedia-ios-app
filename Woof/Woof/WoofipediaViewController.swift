//
//  SecondViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class WoofipediaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UINavigationBarDelegate{
    
    // Mark: Variables
    @IBOutlet var tableView: UITableView!
    var dogsArray = [Breed]()
    var filteredDogs = [Breed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.dogsArray += [Dog(name:"Yorkshire", size:"small", hair:"long hair")]
//        self.dogsArray += [Dog(name:"Pug", size:"small", hair:"short hair")]
//        self.dogsArray += [Dog(name:"Siberian Husky", size:"small", hair:"long hair")]
//        self.dogsArray += [Dog(name:"Beagle", size:"small", hair:"short hair")]
//        self.dogsArray += [Dog(name:"Bulldog", size:"small", hair:"short hair")]
//        self.dogsArray += [Dog(name:"Poodle", size:"large", hair:"long hair")]
//        self.dogsArray += [Dog(name:"Boxer", size:"small", hair:"short hair")]
        

        self.tableView.reloadData()
        
        //let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:58)) // Offset by 20 pixels vertically to take the status bar into account
        
        //let navigationItem = UINavigationItem()
        //navigationItem.title = "Woofipedia"
        
        print("!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!!")
        print(self.navigationItem.title)
        //navigationBar.backgroundColor = UIColor.white
        //navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        //self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        //self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView: backButton), animated: true);
        //navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        //self.view.addSubview(navigationBar)

        
    }
    
    func goBack(){
        print("-----------------------------------------------------------!!!!!!!!!!!!!!")
    }
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 120
//        
//        Dog.searchWithTerm("Yorkshire", completion:{
//            (dogs: [Dog]!, error: NSError!) -> Void in
//            self.dogs = dogs
//            self.tableView = reloadData()
//            for dog in dogs {
//                println(dog.name!)
//                println(dog.filters!)
//            }
//        })
    
    
//     //Number of rows in the table view
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if dogs != nil {
//            return dogs!.count
//        } else {
//            return 0
//        }
//    }
//    
//     //The views for each row
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Dog Cell", forIndexPath: indexPath as IndexPath) as! DogCell
//        cell.dog = dogs[indexPath.row]
//        return cell
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if searching, only show filtered array
        //if not searching, show all array items
        if (tableView == self.searchDisplayController?.searchResultsTableView) {
            return self.filteredDogs.count
        } else {
            return self.dogsArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create a new cell object
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        var dog: Breed
        
        //if using the search bar, get return from filtered bar, if not from 
        //full list
        if(tableView == self.searchDisplayController?.searchResultsTableView)
        {
            dog = self.filteredDogs[indexPath.row]
        } else {
            dog = self.dogsArray[indexPath.row]
        }
        cell.textLabel?.text = dog.breedName
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var dog : Breed
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            dog = self.filteredDogs[indexPath.row]
        } else
        {
            dog = self.dogsArray[indexPath.row]
        }
        
    }
    
    // MARK: Search
    func filterContentForSearchText(searchText: String, scope: String="Title")
    {
        self.filteredDogs = self.dogsArray.filter({(dog: Breed) -> Bool in
            var categoryMatch = (scope == "Title")
            var stringMatch = dog.breedName.range(of: searchText)
            
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool
    {
        self.filterContentForSearchText(searchText: searchString, scope:"Title")
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTabelForSearchScope searchOption: Int) -> Bool{
        self.filterContentForSearchText(searchText: self.searchDisplayController!.searchBar.text!, scope:"Title")
        return true
    }



}

