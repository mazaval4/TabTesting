//
//  FirstViewController.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/8/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var pressed1 = false
    var pressed2 = false
    var pressed3 = false
    let soundID: SystemSoundID = 1016
    
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            
            progressView.setProgress(fractionalProgress, animated: animated)
            progressLabel.text = ("\(counter)%")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        insertStepAlertGoal(text: "", placeholder: "#")
        progressView.setProgress(0, animated: true)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func calibrateButton(_ sender: Any) {
        let calibrate = UIButton(type: UIButtonType.system) as UIButton
        calibrate.setTitle("Tap me", for: UIControlState.normal)
        
        calibrate.isEnabled = false
        self.view.addSubview(calibrate)
        calibrate.layer.cornerRadius = 5
        
        self.counter = 0
        for i in 0..<100 {
            DispatchQueue.global(qos: .background).async {
                sleep(1)
                DispatchQueue.main.async {
                    self.counter += 1
                    return
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Navigation Bar Stuff
    
    private func setupNavigationBarItems () {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "StepPlusHeader"))
        titleImageView.frame = CGRect(x:0, y:0, width: 60, height: 60)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }

    
   // MARK: Today's Goals
    
    @IBOutlet weak var textField: UITextField!
    
    func insertStepAlertGoal(text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
        
    // DISMISS KEYBOARD ACTIONS
        // click anywhere off the keyboard
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // click the done button
            //init toolbar
            let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
            //create left side empty space so that done button set on right side
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(FirstViewController.doneButtonAction))
            //array of BarButtonItems
            var arr = [UIBarButtonItem]()
            arr.append(flexSpace)
            arr.append(doneBtn)
            toolbar.setItems(arr, animated: false)
            toolbar.sizeToFit()
        
            //setting toolbar as inputAccessoryView
            self.textField.inputAccessoryView = toolbar
    }
        // continue dismiss keyboard
        func doneButtonAction() {
            self.view.endEditing(true)
        }
    
    
    // MARK: Feedback Selection

    @IBAction func VButton(_ sender: UIButton) {
        if !pressed1 {
            pressed1 = true
            sender.setImage(#imageLiteral(resourceName: "graybutton"), for:UIControlState.normal)
        } else {
            pressed1 = false
            sender.setImage(#imageLiteral(resourceName: "checkbutton"), for:UIControlState.normal)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    @IBAction func SButton(_ sender: UIButton) {
        if !pressed2 {
            pressed2 = true
            sender.setImage(#imageLiteral(resourceName: "graybutton"), for:UIControlState.normal)
        } else {
            pressed2 = false
            sender.setImage(#imageLiteral(resourceName: "checkbutton"), for:UIControlState.normal)
            AudioServicesPlaySystemSound(1326)
        }
    }
    @IBAction func LButton(_ sender: UIButton) {
        if !pressed3 {
            pressed3 = true
            sender.setImage(#imageLiteral(resourceName: "graybutton"), for:UIControlState.normal)
        } else {
            pressed3 = false
            sender.setImage(#imageLiteral(resourceName: "checkbutton"), for:UIControlState.normal)
            blinkscreen()
        }
    }
    
    func blinkscreen(){
    if let wnd = self.view {
        var v = UIView(frame: wnd.bounds)
        v.backgroundColor = UIColor(red: 0.44, green: 0.87, blue:0.83, alpha:1.0)
        v.alpha = 1
        
        wnd.addSubview(v)
        UIView.animate(withDuration: 0.5, animations: { v.alpha = 0.0}, completion: {(finished:Bool) in
            print("inside")
            v.removeFromSuperview() })
        }
    }
    
}

