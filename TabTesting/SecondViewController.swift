//
//  SecondViewController.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/8/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK

<<<<<<< HEAD
protocol ButtonCellDelegate {
    func cellTapped(cell: CustomCell)
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PTDBeanManagerDelegate, PTDBeanDelegate {
    
// START THE TABLE LABEL STUFF
    
    @IBOutlet weak var tableView: UITableView!
    
    var beanManager: PTDBeanManager?
=======
// protocol ButtonCellDelegate {
// func cellTapped(cell: CustomCell)
// }

class SecondViewController: UIViewController {
    
    var Array = [Int] ()
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Label2: UILabel!
>>>>>>> origin/newBranch
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
<<<<<<< HEAD
        setupNavigationBarItems()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "BluetoothCell")
    }
    
    private func setupNavigationBarItems () {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "StepPlusHeader"))
        titleImageView.frame = CGRect(x:0, y:0, width: 60, height: 60)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "BluetoothCell", for: indexPath) as! CustomCell
        super.awakeFromNib()
        beanManager = PTDBeanManager()
        beanManager!.delegate = self
        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self as? ButtonCellDelegate
        }
        return cell
    }
       // method to run when table view cell is tapped
    
    func cellTapped(cell: CustomCell) {
        self.showAlertForRow(row: tableView.indexPath(for: cell)!.row)
    }
    
    func showAlertForRow(row: Int) {
        let alert = UIAlertController(title: "BEHOLD", message: "Cell at row\(row) was tapped!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Gotcha!", style: UIAlertActionStyle.default, handler: {(test) -> Void in self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

}
=======
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func RandomNumber(_ sender: Any) {
        
        let RandomNumberGen = arc4random_uniform(30) + 15  // (max value) + min value
        Label.text = String(RandomNumberGen)
        self.RandomOutput()
    }
    
    
    func RandomOutput () {
        
        // function that converts string to integer
        let number:Int! = Int(Label.text!)
        
        if number <= 20
        {
            Label2.text = "Too short"
        }
            
        else
        {
            Label2.text = "Good step"
        }
        
    }
}


>>>>>>> origin/newBranch
