//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation
import UIKit


struct DroneOperation {
    var droneOperationUUID: String
    var droneName: String
    var droneDescription: String
    var droneImage: String
    var droneTakeOffCoordinate: String
    var droneLandingCoordinate: String
}


struct OperationDescription {
    let droneOperation: DroneOperation
    var startTime: String
    var endTime: String
    
}

