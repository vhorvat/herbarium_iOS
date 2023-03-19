//
//  AllDataViewController.swift
//  BLE WPLANT
//
//  Created by Viktor Horvat on 15.01.2023..
//

import UIKit

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

class AllDataViewController: UIViewController {
    
    @IBOutlet weak var current_time: UILabel!
    @IBOutlet weak var current_date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let timeString = String(hour) + ":" + String(minutes)
        current_time.text = timeString
        
        let formatDate = date.getFormattedDate(format: "EEEE, MMM d, yyyy.")
        current_date.text = formatDate

        
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
