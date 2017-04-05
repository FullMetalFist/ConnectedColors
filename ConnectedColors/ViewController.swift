//
//  ViewController.swift
//  ConnectedColors
//
//  Created by Michael Vilabrera on 4/5/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let colorService = ColorServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }
    
    @IBAction func blueTapped() {
        colorService.send(colorName: "blue")
    }
    
    @IBAction func greenTapped() {
        colorService.send(colorName: "green")
    }
    
    func change(color: UIColor) {
        UIView.animate(withDuration: 0.5) { 
            self.view.backgroundColor = color
        }
    }
}

extension ViewController: ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "blue":
                self.change(color: .blue)
            case "green":
                self.change(color: .green)
            default:
                print("unknown color value received: \(colorString)")
            }
        }
    }
}
