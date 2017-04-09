//
//  FirstViewController.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/8/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var items: [String] = ["We", "Heart", "StepPlus"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     //   self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       //
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        setupNavigationBarItems()
    }

// START TABLE VIEW STUFF
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.items.count;
        return 2;
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell") as! TextInputTableViewCell
            cell.configure(text: "", placeholder: "#")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackSelection") as! FeedbackTypesTableViewCell
            // set data for cell here
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    private func setupNavigationBarItems () {
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "StepPlusHeader"))
        titleImageView.frame = CGRect(x:0, y:0, width: 60, height: 60)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

