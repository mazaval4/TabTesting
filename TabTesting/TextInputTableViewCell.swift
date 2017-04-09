//
//  TextInputTableViewCell.swift
//  TabTesting
//
//  Created by Arianna Moreno on 4/4/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit

public class TextInputTableViewCell: UITableViewCell {
 
    @IBOutlet weak var textField: UITextField!
    
    public func configure(text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
        
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
    }
}
