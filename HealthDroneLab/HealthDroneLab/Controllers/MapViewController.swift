//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    weak var coordinateService: ICoordinateService?

    
    private let regionRadius: CLLocationDistance = 40000
    
    @IBOutlet weak var mapView: MKMapView!
    
    private lazy var hospital: Hospital = Hospital(name: hospitalName ?? "Svendborg")
    
    var hospitalName: String? {
        didSet {
            hospital.setDefaultHospital(hospitalName: hospitalName ?? "Svendborg")   
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(coordinateNotifciation(_:)), name: Notifications.coordinateNotification, object: nil)
    }
    
    @objc func coordinateNotifciation(_ notification: Notification) {
        if let coordinate = coordinateService?.getCoordinate() {
            addCoordinateToMap(arrayOfPoints: coordinate)
        }
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        addCoordinateToMap(arrayOfPoints: (coordinateService?.getCoordinate())!)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        let initialLocation = CLLocation(latitude: hospital.getLatitude(), longitude: hospital.getLongtiude())
        centerMapOnLocation(location: initialLocation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func addCoordinateToMap(arrayOfPoints: [[Double]]) {
        let route = MKPointAnnotation()
        
        for coordinates in 0..<arrayOfPoints.count {
            route.title = "Location point"
            route.coordinate = CLLocationCoordinate2D(latitude: arrayOfPoints[coordinates][1], longitude: arrayOfPoints[coordinates][0])
            print("Coordinate: \(coordinates)")
            print(route.coordinate)
            
            mapView.addAnnotation(route)
        }
    }

}

