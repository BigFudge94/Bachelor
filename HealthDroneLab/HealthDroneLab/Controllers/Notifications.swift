//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation

protocol INotifcations: class {
    static var coordinateNotification: NSNotification.Name {get}
}



class Notifications : INotifcations  {
    
    static let coordinateNotification = NSNotification.Name(rawValue: "NotificationEvent")
    
}

