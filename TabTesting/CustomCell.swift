//
//  CustomCell.swift
//  TabTesting
//
//  Created by Arianna Moreno on 3/22/17.
//  Copyright © 2017 Arianna's Apps. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK

class CustomCell: UITableViewCell, PTDBeanManagerDelegate, PTDBeanDelegate  {

    @IBOutlet weak var bluetoothTextLabel: UILabel!
    
    // Declare variables we will use throughout the app
    var beanManager: PTDBeanManager?
    var yourBean: PTDBean?
    var lightState: Bool = false
    var buttonDelegate: ButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

 //   override func setSelected(_ selected: Bool, animated: Bool) {
 //       super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
 //   }
    
    // START LIGHT BLUE BEAN STUFF
    
    // After the view is added we will start scanning for Bean peripherals
    func viewDidAppear(_ animated: Bool) {
        startScanning()
    }
    
    // Bean SDK: We check to see if Bluetooth is on.
    func beanManagerDidUpdateState(_ beanManager: PTDBeanManager!) {
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
    func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!) {
        if let e = error {
            print(e)
        }
        
        print("Found a Bean: \(bean.name)")
        if bean.name == "Bean update image" {
            yourBean = bean
            print("got your bean")
            connectToBean(bean: yourBean!)
        }
    }
    
    // Bean SDK: connects to Bean
    func connectToBean(bean: PTDBean) {
        var error: NSError?
        beanManager?.connect(to: yourBean, withOptions:nil, error: &error)
        yourBean?.delegate = self    }
    
    // Bean SDK: Send serial datat to the Bean
    func sendSerialData(beanState: NSData) {
        yourBean?.sendSerialData(beanState as Data!)
    }
    
    // Change LED text when button is pressed
    func updateLedStatusText(lightState: Bool) {
        let onOffText = lightState ? "ON" : "OFF"
        bluetoothTextLabel.text = "Bluetooth is \(onOffText)"
    }
    
    @IBAction func bluetoothButton(_ sender: AnyObject) {
    lightState = !lightState
    updateLedStatusText(lightState: lightState)
    let data = NSData(bytes: &lightState, length: MemoryLayout<Bool>.size)
    sendSerialData(beanState: data)
        if let delegate = buttonDelegate {
            delegate.cellTapped(cell: self)
        }
       }

}
