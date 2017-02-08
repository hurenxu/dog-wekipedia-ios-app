//
//  SecondViewController.swift
//  Hompage
//
//  Created by Joann Chen on 2/7/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//

import UIKit

class WoofipediaViewController: UIViewController, UITableViewDelegate{
    
    // Mark: Variables
    
    var dogs: [Dog]!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 120
        
//        Dog.searchWithTerm("Yorkshire", completion:{
//            (dogs: [Dog]!, error: NSError!) -> Void in
//            self.dogs = dogs
//            self.tableView = reloadData()
//            for dog in dogs {
//                println(dog.name!)
//                println(dog.filters!)
//            }
//        })
    }
    
    // Number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dogs != nil {
            return dogs!.count
        } else {
            return 0
        }
    }
    
    // The views for each row
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Dog Cell", forIndexPath: indexPath as IndexPath) as! DogCell
//        cell.dog = dogs[indexPath.row]
//        return cell
//    }


//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

