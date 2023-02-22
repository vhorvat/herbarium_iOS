//
//  AllDataViewController.swift
//  BLE WPLANT
//
//  Created by Viktor Horvat on 15.01.2023..
//

import UIKit

class AllDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if ((Shared.instance.peripheral?.name) != nil){
            print(Shared.instance.peripheral.name)
        } else {
            print("Not connected")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
