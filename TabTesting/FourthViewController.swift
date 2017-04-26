//
//  FourthViewController.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/21/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK

struct Temperature {
    enum State {
        case unknown, cold, cool, warm, hot
    }
    
    var degreesCelcius: Float
    
    var degressFahrenheit: Float {
        return (degreesCelcius * 1.8) + 32.0
    }
    
    func state() -> State {
        switch Int(degressFahrenheit) {
        case let x where x <= 39: return .cold
        case 40...65: return .cool
        case 66...80: return .warm
        case let x where x >= 81: return .hot
        default: return .unknown
        }
    }
}

class FourthViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate {
    
    // Declare variables we will use throughout the app
    var beanManager: PTDBeanManager?
    var yourBean: PTDBean?
    var lightState: Bool = false
    
    // MARK: Properties
    @IBOutlet weak var ledTextLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    fileprivate var currentTemperature: Temperature = Temperature(degreesCelcius: 0) {
        didSet {
            updateTemperatureView()
        }
    }
    
    fileprivate let refreshControl = UIRefreshControl()
    
    
    // After view is loaded into memory, we create an instance of PTDBeanManager
    // and assign ourselves as the delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        beanManager = PTDBeanManager()
        beanManager!.delegate = self
        
        // Update the name label.
        tempLabel.text = yourBean?.name ?? "Unknown"
        
        // Add pull-to-refresh control.
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        //scrollView.addSubview(refreshControl)
        yourBean?.readTemperature()
    }
    
    // After the view is added we will start scanning for Bean peripherals
    override func viewDidAppear(_ animated: Bool) {
        startScanning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        yourBean?.readTemperature()
    }
    
    // Bean SDK: We check to see if Bluetooth is on.
    func beanManagerDidUpdateState(_ beanManager: PTDBeanManager!) {
        
        switch beanManager.state {
        case .unsupported:
            let alert = UIAlertController(title: "Error", message: "This device is unsupported.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .poweredOff:
            let alert = UIAlertController(title: "Error", message: "Please turn Bluetooth ON.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .poweredOn:
            beanManager.startScanning(forBeans_error: nil)
        case .unknown, .resetting, .unauthorized:
            break
        }
        
        var scanError: NSError?
        
        if beanManager!.state == BeanManagerState.poweredOn {
            startScanning()
            if var e = scanError {
                print(e)
            } else {
                print("Please turn on your Bluetooth")
            }
        }
    }
    
    // Scan for Beans
    func startScanning() {
        var error: NSError?
        beanManager!.startScanning(forBeans_error: &error)
        if let e = error {
            print(e)
        }
    }
    
    // We connect to a specific Bean
    func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!,
                     error: Error!) {
        if let e = error {
            print(e)
        }
        
        print("Found a Bean: \(bean.name)")
        if bean.name == "Ariannas back off" {
            yourBean = bean
            print("got your bean")
            connectToBean(bean: yourBean!)
        }
    }
    
    // Bean SDK: connects to Bean
    func connectToBean(bean: PTDBean){
        var error: NSError?
        beanManager?.connect(to: yourBean, withOptions:nil, error: &error)
    }
    
    // Bean SDK: Send serial datat to the Bean
    func sendSerialData(beanState: NSData) {
        yourBean?.sendSerialData(beanState as Data!)
    }
    
    // Change LED text when button is pressed
    func updateLedStatusText(lightState: Bool) {
        let onOffText = lightState ? "ON" : "OFF"
        ledTextLabel.text = "Led is: \(onOffText)"
    }
    
    // Mark: Actions
    // When we pressed the button, we change the light state and
    // We update the label, and send the Bean serial data
    @IBAction func pressMeButton(_ sender: AnyObject) {
        print(yourBean?.readTemperature() as Any)
        lightState = !lightState
        updateLedStatusText(lightState: lightState)
        let data = NSData(bytes: &lightState, length: MemoryLayout<Bool>.size)
        sendSerialData(beanState: data)
        if ledTextLabel.text == nil {
            ledTextLabel.text = "Led is: ON"
        } else if ledTextLabel.text == "Led is: ON" {
            ledTextLabel.text = "Led is: ON"
        } else {
            ledTextLabel.text = "Led is: OFF"
        }
    }
    
    func didPullToRefresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        yourBean?.readTemperature()
    }
    
    // MARK: - Helper
    
    func updateTemperatureView() {
        // Update the temperature label.
         tempLabel.text = String(format: "%.f℉", currentTemperature.degressFahrenheit)
         print(currentTemperature.degressFahrenheit)
        
        // Update the background color.
        var backgroundColor: UIColor
        
        switch currentTemperature.state() {
        case .unknown: backgroundColor = .black
        case .cold: backgroundColor = .CBColdColor()
        case .cool: backgroundColor = .CBCoolColor()
        case .warm: backgroundColor = .CBWarmColor()
        case .hot: backgroundColor = .CBHotColor()
        }
        
        UIView.animate(withDuration: 0.4, animations: { [unowned self] in
      //      self.scrollView.backgroundColor = backgroundColor
        })
    }
    
}
