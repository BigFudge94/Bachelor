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
                let operations = Resource<[Operation]>(get: url)
                URLSession.shared.load(operations) {
                    if let operations = $0 {
                        self!.insertIntoDroneDocument(operations: operations)
                        
                        if self!.requestIsRelevant(localURL: url) {
                            self!.updateTableView()
                        }
                    } else {
                        self!.failedDroneFetchUI()
                    }
                }
            }
        }
    }
    
    private func insertIntoDroneDocument(operations: [Operation]) {
        for operation in operations {
            
            self.droneDocuments.append(extractDrone(operation: operation))
        }
    }
    
    private func extractDrone(operation: Operation) -> DroneOperation {
         let drone = DroneOperation(droneOperationUUID: operation.uniqueIdentifier, droneName: operation.uas.nickname, droneDescription: operation.flightStatus.rawValue.self, droneImage: "droneTEst\(generateRandomImage()).jpeg", droneTakeOffCoordinate: operation.takeOffPosition.getCoordinateAsString(), droneLandingCoordinate: operation.landPosition.getCoordinateAsString())
        
        return drone
    }
    
    private func generateRandomImage() -> Int {
        return Int.random(in: 2 ..< 13) //Number of photos
    }
    
    private func requestIsRelevant(localURL: URL) -> Bool {
        if localURL == self.droneOperationURL {
               return true
        }
        return false
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func failedDroneFetchUI() {
        let alert = UIAlertController(title: "Could not find drones", message: "please try again later.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }

}





