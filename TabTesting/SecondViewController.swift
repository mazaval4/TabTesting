//
//  SecondViewController.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/8/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK

// protocol ButtonCellDelegate {
// func cellTapped(cell: CustomCell)
// }

class SecondViewController: UIViewController {
    
    var Array = [Int] ()
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


