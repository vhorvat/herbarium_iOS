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

class AllDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let measurment = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CusomTableViewCell
        cell.label.text = measurment.title
        cell.imageView?.image = UIImage(named: measurment.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DidSelectRow" + String(indexPath.row))
        let segueIdentifier: String
        switch indexPath.row {
        case 0:
            segueIdentifier = "temperatura_view"
        case 1:
            segueIdentifier = "vlaga_view"
        case 2:
            segueIdentifier = "dim_view"
        case 3:
            segueIdentifier = "osvijetljenje_view"
        case 4:
            segueIdentifier = "vlaznost_view"
        case 5:
            segueIdentifier = "hoc_view"
        case 6:
            segueIdentifier = "sumpor_view"
        case 7:
            segueIdentifier = "tlak_view"
        case 8:
            segueIdentifier = "benzen_view"
        case 9:
            segueIdentifier = "pm25_view"
        case 10:
            segueIdentifier = "co_view"
        case 11:
            segueIdentifier = "ch4_view"
        case 12:
            segueIdentifier = "lpg_view"
        case 13:
            segueIdentifier = "nh3_view"
        case 14:
            segueIdentifier = "co2_view"
        case 15:
            segueIdentifier = "o3_view"
        default:
            segueIdentifier = "temperatura_view"
        }
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    @IBOutlet weak var current_time: UILabel!
    @IBOutlet weak var current_date: UILabel!
    @IBOutlet weak var table: UITableView!
    
    struct Measurment {
        let title: String
        let imageName: String
    }
    
    let data: [Measurment] = [
    Measurment(title: "Temperatura", imageName: "termometar"),
    Measurment(title: "Vlaga zraka", imageName: "vlaga"),
    Measurment(title: "Dim", imageName: "smoke"),
    Measurment(title: "Osvijetljenje", imageName: "svijetlo"),
    Measurment(title: "Vlažnost tla", imageName: "vlaznost_tla"),
    Measurment(title: "Hlapljivi organski spojevi", imageName: "voc"),
    Measurment(title: "Sumpor", imageName: "sumpor"),
    Measurment(title: "Tlak zraka", imageName: "tlak"),
    Measurment(title: "Benzen", imageName: "benzen"),
    Measurment(title: "PM2.5", imageName: "pm2.5"),
    Measurment(title: "Ugljični monoksid (CO)", imageName: "monoksid"),
    Measurment(title: "Metan (CH4)", imageName: "metan"),
    Measurment(title: "LPG", imageName: "lpg"),
    Measurment(title: "NH3", imageName: "nh3"),
    Measurment(title: "Ugljikov dioksid (CO2)", imageName: "dioksid"),
    Measurment(title: "Ozon (O3)", imageName: "ozone"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
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
