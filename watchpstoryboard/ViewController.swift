//
//  ViewController.swift
//  watchpstoryboard
//
//  Created by Viktor Horvat on 12.04.2022..
//

import UIKit
import CoreBluetooth
import CoreLocation
import UserNotifications
import Foundation

class Shared {
    private init(){ }
    static let instance = Shared()
    var bleManager: CBCentralManager!
    var peripheral: CBPeripheral!
    
    struct Zapis {
        var index = 0
        var temperature = 0.0
        var air_m = 0.0
        var smoke = 0.0
        var light = 0.0
        var soil_m = 0.0
        var voc = 0.0
        var sulf = 0.0
        var air_p = 0.0
        var benzene = 0.0
        var pm25 = 0.0
        var monoxide = 0.0
        var methane = 0.0
        var lpg = 0.0
        var nh3 = 0.0
        var dioxide = 0.0
        var ozone = 0.0
    }
    
    var zapis = Zapis()
    
    var AllData: [Zapis] = []
    
    
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var tableView1: UITableView!
    
    
    var allData = ["","","","","","","","","","","","","","","","",""]
    var deviceNames = [String]()
    
    var wPeripheral: CBPeripheral!
    var wCharacteristic: CBCharacteristic!
    
    
    let notifCenter = UNUserNotificationCenter.current()
    var allBluetoothPeripherals = [CBPeripheral]()
    
    let arrayOfServices: [CBUUID] = [CBUUID(string: "5701")]
    
    var currentConnectedName = "NULL"
    var stateOfDoors = "1"
    var currentTemperature = 0
    
    var centralManager = Shared.instance.bleManager
    var myPeripheral = Shared.instance.peripheral
    
    
    
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "FER Watchplant"
        content.body = "Dostupan je novi senzor u blizini"
        let date = Date().addingTimeInterval(1)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        notifCenter.add(request) { (error) in
        }
        print("NOTIFIKACIJA!")
    }
    
    func createData(){
        for i in 0...29{
            Shared.instance.AllData.append(Shared.instance.zapis)
            Shared.instance.AllData[i].index = i
        }
        print(Shared.instance.AllData)
    }
    
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("BLE STATE ON")
            deviceNames.removeAll()
            central.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            print("BLE PROBLEM")
            currentConnectedName="Error"
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let pname = peripheral.name {
            print (pname)
            deviceNames.append(pname)
            allBluetoothPeripherals.append(peripheral)
            self.tableView1.reloadData()
            scheduleNotification()
            print(deviceNames)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Spajam se...")
        Shared.instance.peripheral = myPeripheral
        self.myPeripheral?.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print ("Services:\(String(describing : peripheral.services))")
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Uređaj:\(peripheral) i servis na njemu: \(service)")
        for charasteristic in service.characteristics! {
            print(charasteristic.uuid)
            if (charasteristic.uuid) == CBUUID(string: "8DD6A1B7-BC75-4741-AA26-264AF7DADADA"){
                peripheral.setNotifyValue(true, for: charasteristic)
                print("istina")
            }
            if (charasteristic.uuid) == CBUUID(string: "FA2AF5EC-E01F-11EC-9D64-0242AC120002"){
                print("I WROTE")
                wPeripheral=peripheral
                wCharacteristic=charasteristic
                peripheral.writeValue(stateOfDoors.data(using: .utf8)!, for: charasteristic, type: .withoutResponse)
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if (characteristic.uuid) == CBUUID(string: "8DD6A1B7-BC75-4741-AA26-264AF7DADADA"){
            let currentValue=characteristic.value
            let decodedString = String(bytes: currentValue!, encoding: .utf8)
            print(decodedString)
        }
    }
    
    //FUNKCIJE ZA iBeacon LOKACIJU
    
    
    @IBOutlet weak var greenhouseSwitch: UISwitch!
    @IBAction func switchDidChange(_ sender: UISwitch){
        if sender.isOn{
            stateOfDoors="1"
            print("ON")
            wPeripheral.writeValue(stateOfDoors.data(using: .utf8)!, for: wCharacteristic, type: .withResponse)
            wPeripheral.readValue(for: wCharacteristic)
            greenHouseDoorStatus.text = "OPEN"
        } else {
            stateOfDoors="0"
            print("OFF")
            wPeripheral.writeValue(stateOfDoors.data(using: .utf8)!, for: wCharacteristic, type: .withResponse)
            wPeripheral.readValue(for: wCharacteristic)
            greenHouseDoorStatus.text = "CLOSED"
        }
    }
    
    @IBOutlet weak var greenHouseDoorState: UILabel!
    @IBOutlet weak var nameToShowLabel: UILabel!
    @IBOutlet weak var greenHouseDoorStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    //UI:
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.allBluetoothPeripherals[indexPath.row].delegate=self
        
        print ("Stisnuo si redak:\(indexPath.row)")
        
        self.myPeripheral = allBluetoothPeripherals[indexPath.row]
        
        
        centralManager?.stopScan()
        centralManager?.connect(allBluetoothPeripherals[indexPath.row], options: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return deviceNames.count
        }
        print(allData.count)
        return allData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = deviceNames[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text=allData[indexPath.row]
            return cell
        }
    }
}
