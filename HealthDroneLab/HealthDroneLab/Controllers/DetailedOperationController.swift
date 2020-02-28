//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import UIKit

class ComponentOperationMapController: UITableViewController {
    
    var operationURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "Operation Details" {
            
            let identifier = segue.identifier!
            
            
            let detailedDroneController = segue.destination as? DetailedDroneController
            let mapPointController = segue.destination as? MapPointController
            
            detailedDroneController?.droneOperationURL = operationURL
            mapPointController?.operationURL = operationURL
            
            
            //controller?.droneOperationURL = operationURL
            
        }
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}
