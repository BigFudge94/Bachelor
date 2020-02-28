//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation
import UIKit
import MapKit



protocol ICoordinateService: class {
    func getCoordinate() -> [[Double]]
}


class OperationController: UIViewController, ICoordinateService, SetUrl  {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var droneNickNameLabel: UILabel!
    @IBOutlet weak var droneFlightStatusLabel: UILabel!
    @IBOutlet weak var droneStartTimeLabel: UILabel!
    @IBOutlet weak var droneEndTimeLabel: UILabel!
    @IBOutlet weak var droneLandingPositionLabel: UILabel!
    @IBOutlet weak var droneTakeOffPosition: UILabel!
    @IBOutlet weak var droneImageView: UIImageView!
    @IBOutlet weak var toggleContent: UISegmentedControl!
    
    private var isCrew = false

    var droneOperationURL: URL? {
        didSet {
            operation = nil
            fetchOperation()
        }
    }
    
    private var operation: Operation? {
        didSet {
            NotificationCenter.default.post(name: Notifications.coordinateNotification, object: nil, userInfo: nil)
            spinner?.stopAnimating()
            isCrew = false
        }
    }
    

    @IBAction func segmentChange(_ sender: Any) {
        switch toggleContent.selectedSegmentIndex
        {
        case 0:
            setUpOperationUI()
        case 1:
            setUpCrewUI()
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue")
        if segue.identifier == "Coordinate" {
            DispatchQueue.global(qos: .userInitiated).async {
                [weak self] in
                
                let destinationViewController = segue.destination as! MapViewController
                destinationViewController.coordinateService = self
            }
        }
    }
    
    private func fetchOperation() {
        if let url = droneOperationURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                
                [weak self] in
                
                let pastOperations = Resource<Operation>(get: url)
                URLSession.shared.load(pastOperations) {
                    let operation = $0!
                    
                    DispatchQueue.main.async {
                        if url == self?.droneOperationURL{
                            self?.operation = operation
                            self?.droneImageView.image = self?.generateRandomImage()
                            self?.setUpOperationUI()
                            
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func generateRandomImage() -> UIImage {
        let number = Int.random(in: 2 ..< 13)
        return UIImage(named: "droneTEst\(number).jpeg")!
    }
    
    private func setUpOperationUI(){
        droneNickNameLabel.text = "Name \(operation!.uas.nickname)"
        droneFlightStatusLabel.text = "Flight status: \(operation!.uas.flightStatus.rawValue)"
        droneStartTimeLabel.text = "Start Time: \(operation!.geoZone.startTime)"
        droneEndTimeLabel.text = "End Time: \(operation!.geoZone.endTime)"
        droneTakeOffPosition.text = "Initial Position: \(operation!.landPosition.getCoordinateAsString())"
        droneLandingPositionLabel.text = "Final Position: \(operation!.landPosition.getCoordinateAsString())"
        //droneImageView.image = self.generateRandomImage()
    }
    
    private func setUpCrewUI() {
        droneNickNameLabel.text = "Pilot Name : \(operation!.crew.contact.name)"
        droneFlightStatusLabel.text = "Pilot contact \(operation!.crew.contact.email)"
        droneStartTimeLabel.text = "First Name: \(operation!.crew.contact.firstName)"
        droneEndTimeLabel.text = "Last Name: \(operation!.crew.contact.lastName)"
        droneLandingPositionLabel.text = "Contact: \(operation!.crew.contact.email)"
        droneTakeOffPosition.text = "Did fly operation : \(operation!.uniqueIdentifier)"
        droneNickNameLabel.text = "Pilot id: \(operation!.crew.pilot)"
        droneFlightStatusLabel.text = "\(operation!.crew.contact.name)"
    }
    
    func getCoordinate() -> [[Double]] {
        print("OperationController .getCoordinate() ")
        return operation?.originalGeometry.coordinates[0] ?? [[]]
    }
    
}

