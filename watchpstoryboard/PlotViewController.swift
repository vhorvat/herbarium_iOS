//
//  DeviceViewController.swift
//  BLE WPLANT
//
//  Created by Viktor Horvat on 15.01.2023..
//

import UIKit
import Foundation
import AZSClient


class DeviceViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        // Do any additional setup after loading the view.
    }
    
    func JSONIfyData()->String{
        do {
            let jsonData = try JSONEncoder().encode(Shared.instance.AllData)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonString
        } catch { print(error) }
        return "Error"
    }
    
    func sendDataToAzure(data: String){
        let account = try! AZSCloudStorageAccount(fromConnectionString:"DefaultEndpointsProtocol=https;AccountName=ferzariwatchplant;AccountKey=H6e6YvK5X3+J0Kv3KeHwDHTC22s9+Q98xkVSpSp2jSj2ilcVGlD5C5bHYbmxW+GB89GLOyWpbIAu+AStenrXmg==;EndpointSuffix=core.windows.net")
        let blobClient: AZSCloudBlobClient = account.getBlobClient()
        let blobContainer: AZSCloudBlobContainer = blobClient.containerReference(fromName: "herbarium-data")
        blobContainer.createContainerIfNotExists(with: AZSContainerPublicAccessType.container, requestOptions: nil, operationContext: nil) { (NSError, Bool) -> Void in
            if ((NSError) != nil){
                NSLog("Error in creating container.")
            }
            else {
                let name=CFUUIDCreateString(nil, CFUUIDCreate(nil))
                let blob: AZSCloudBlockBlob = blobContainer.blockBlobReference(fromName: name! as String) //If you want a random name, I used let imageName = CFUUIDCreateString(nil, CFUUIDCreate(nil))
                blob.upload(fromText: data, completionHandler: {(NSError) -> Void in
                    NSLog("Ok, uploaded !")
                })
            }
        }
        
    }
    
    func createUI(){
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        var data = JSONIfyData()
        sendDataToAzure(data: data)
        print("Data sent correctly")
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
