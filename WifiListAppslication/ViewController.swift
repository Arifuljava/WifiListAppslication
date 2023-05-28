//
//  ViewController.swift
//  WifiListAppslication
//
//  Created by sang on 28/5/23.
//

import UIKit
import UIKit
import NetworkExtension



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var wifiNetworks: [NEHotspotNetwork] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
               
               fetchWifiNetworks() // Fetch available Wi-Fi networks
    }


    func fetchWifiNetworks() {
        print("gggg")
           NEHotspotHelper.register(options: nil, queue: DispatchQueue.main) { [weak self] (command) in
               guard let strongSelf = self else { return }
               
               if let networks = command.networkList {
                   strongSelf.wifiNetworks = networks
                   DispatchQueue.main.async {
                       strongSelf.tableView.reloadData() // Reload the table view data
                   }
               }
           }
        print(wifiNetworks.count)
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return wifiNetworks.count
           print(wifiNetworks.count)
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath)
           let network = wifiNetworks[indexPath.row]
           cell.textLabel?.text = network.ssid
           
           return cell
       }
   }

