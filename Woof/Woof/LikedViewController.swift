//
//  LikedViewController.swift
//  Woof
//
//  Created by Meiyi He on 3/10/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class LikedViewController: UIViewController, UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate{

    let likedArray = Functionalities.myUser?.favoriteDogBreeds
    var scrollView: UIScrollView! = nil
    var table: UITableView! = nil
    let result_origin = CGPoint(x:12, y:40)
    //let TITLE_SIZE: CGSize = CGSize(width: 353, height: 40)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:65)) // Offset by 20 pixels vertically to take the status bar into account
        
        //tableView.rowHeight = 80
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Liked Dog"
        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        self.view.addSubview(navigationBar)

        scrollView = UIScrollView(frame: CGRect(x:0, y:58, width:self.view.frame.size.width, height:self.view.frame.size.height-CGFloat(64)))
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        self.view.addSubview(scrollView)
        

        table = UITableView(frame: CGRect(origin: result_origin, size: CGSize(width: 353, height: self.view.frame.height-12)))
        setUpTable(myColor: UIColor.white, myTable: table)
        
        table.delegate = self
        table.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func setUpTable(myColor: UIColor, myTable: UITableView) {
        
        myTable.backgroundColor = myColor
        myTable.layer.cornerRadius = CGFloat(10)
        myTable.rowHeight = CGFloat(80)
        //myTable.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
        scrollView.addSubview(myTable)
        myTable.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func goBack(){
        print("call goBack function")
        dismiss(animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
