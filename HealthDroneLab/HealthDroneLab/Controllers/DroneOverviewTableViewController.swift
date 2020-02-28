//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import UIKit

protocol SetUrl: class {
    var droneOperationURL: URL? { get set }
}

class DroneOverviewTableController: UITableViewController, SetUrl {
    
    var droneOperationURL: URL?
    
    override func viewWillAppear(_ animated: Bool) {
        droneDocuments.removeAll()
        fetchOperation()
    }
    
    var droneDocuments = [
        DroneOperation(droneOperationUUID: "Test", droneName:"DJI MAVIC MINI", droneDescription: "On the Move!", droneImage: "droneTEst.jpeg", droneTakeOffCoordinate: "Ærø",droneLandingCoordinate: "Svendborg")
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Operation Details" {
            let identifier = segue.identifier!
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let operation = droneDocuments[indexPath.row]
                let controller = segue.destination as? OperationController
                
                controller?.droneOperationURL = URLs.urlDictionary[identifier]?.appendingPathComponent(operation.droneOperationUUID)
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return droneDocuments.count
    }
    
    /*
     Customize current custom cell.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! DroneCustomTableViewCell
        
        let drone = droneDocuments[indexPath.row]
        cell.headLabel?.text = drone.droneName
        cell.descriptionLabel?.text = drone.droneDescription
        cell.droneIageLabel?.image = UIImage(named: drone.droneImage)
        cell.takeOffLabel?.text = drone.droneTakeOffCoordinate
        cell.landingLabel?.text = drone.droneLandingCoordinate
        
        return cell
    }
    
    
    
    private func fetchOperation(){
        if let url = droneOperationURL {
            
            DispatchQueue.global(qos: .userInitiated).async {
                [weak self] in
                
                let pastOperations = Resource<[Operation]>(get: url)
                
                URLSession.shared.load(pastOperations) {
                    
                    if let pastOperations = $0 {
                        for operations in pastOperations {
                            
                            let number = Int.random(in: 2 ..< 13)
                            
                            let anotherDrone = DroneOperation(droneOperationUUID: operations.uniqueIdentifier, droneName: operations.uas.nickname, droneDescription: operations.flightStatus.rawValue.self, droneImage: "droneTEst\(number).jpeg", droneTakeOffCoordinate: operations.takeOffPosition.getCoordinateAsString(), droneLandingCoordinate: operations.landPosition.getCoordinateAsString())
                            
                            self!.droneDocuments.append(anotherDrone)
                        }
                        DispatchQueue.main.async {
                            if url == self?.droneOperationURL {
                                self!.tableView.reloadData()
                            }
                            
                        }
                        
                    } else {
                        self!.failedDroneFetchUI()
                    }
                    
                }
            }
        }
    }
    
    private func failedDroneFetchUI() {
        let alert = UIAlertController(title: "Could not find drones", message: "please try again later.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    
}





