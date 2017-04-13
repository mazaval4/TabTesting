//
//  ThirdViewController.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/21/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNavigationBarItems()
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
