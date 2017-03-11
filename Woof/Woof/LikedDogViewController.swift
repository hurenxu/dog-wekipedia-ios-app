//
//  LikedDogViewController.swift
//  Woof
//
//  Created by Meiyi He on 3/10/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class LikedDogViewController: UITableViewController, UINavigationBarDelegate {

    let likedArray = Functionalities.myUser?.favoriteDogBreeds
    let testArray = ["a","b","c"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:58)) // Offset by 20 pixels vertically to take the status bar into account
        
        tableView.rowHeight = 80
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Liked Dog"
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        self.tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
        
        
        self.view.addSubview(navigationBar)
        
        //self.tableView.contentInset = UIEdgeInsetsMake(60.0, 0.0, 0.0, 0.0)
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 60, 0, 0)
    }
    
    func goBack(){
        print("call goBack function")
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "iPetViewController") as! iPetViewController
        //        self.present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
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
        //print(testArray.count)
        return likedArray!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        

        cell.textLabel?.text = likedArray?[indexPath.row]

        return cell
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
