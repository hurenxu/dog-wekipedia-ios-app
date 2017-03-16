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
    let breedList = Functionalities.breedList

    var myTitle: UILabel! = nil
    let TITLE_SIZE = CGSize(width: 320, height: 40)
    let TITLE_OFFSET: CGFloat = CGFloat(75)
    let FONT = "Rubik"
    let FONT_SIZE = 20
    
    var table: UITableView! = nil
    let TABLE_SIZE = CGSize(width: 320, height: 480)
    let TABLE_OFFSET: CGFloat = CGFloat(55)

    let HALF: CGFloat = CGFloat(2)
    let CORNER_RADIUS: CGFloat = CGFloat(10)
        
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)

    var breedSelected: Breed! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.white
        //let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:65)) // Offset by 20 pixels vertically to take the status bar into account
        
        //tableView.rowHeight = 80
        
        /**
        let navigationItem = UINavigationItem()
        navigationItem.title = "Liked Dog"
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        self.view.addSubview(navigationBar)*/

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge-shade.jpg")!)
        
        self.title = "Liked Dog"
        //self.navigationItem.titleView?.frame = CGRect(origin: (self.navigationItem.titleView?.frame.origin)!, size: CGSize(width: (self.navigationItem.titleView?.frame.width)!, height: 100))
        // self.navigationItem.titleView?.sizeToFit()
        self.tabBarItem.title="Liked Dog"

        let TITLE_ORIGIN = CGPoint(x: self.view.frame.width / HALF - TITLE_SIZE.width / HALF, y: TITLE_OFFSET)
        let TABLE_ORIGIN = CGPoint(x: TITLE_ORIGIN.x, y: TITLE_ORIGIN.y + TABLE_OFFSET)
        
        myTitle = UILabel(frame: CGRect(origin: TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Select to View Detail Page", myFont: FONT, myFontSize: FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: myTitle, myColor: pink)
        
        table = UITableView(frame: CGRect(origin: TABLE_ORIGIN, size: TABLE_SIZE))
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
        //myTable.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        self.view.addSubview(myTable)
    }

    // function to set up the common specs of labels
    func setUpLabel(myText: String, myFont: String, myFontSize: Int, myAlignment: NSTextAlignment, myLabel: UILabel, myColor: UIColor) {
        
        myLabel.text = myText
        myLabel.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myLabel.textAlignment = myAlignment
        myLabel.backgroundColor = myColor
        myLabel.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myLabel.clipsToBounds = true
        self.view.addSubview(myLabel)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentString = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        for myBreed in breedList {
            
            if myBreed.getBreedName() == currentString {
                
                breedSelected = myBreed
                self.performSegue(withIdentifier: "ToDetailViewSegue2", sender: tableView)
            }
        }
    }
    
    // segue to switch to detail page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Prepare for Detail View Segue")
        
        if segue.identifier == "ToDetailViewSegue2" {
            
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.detailDog = breedSelected
        }
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
