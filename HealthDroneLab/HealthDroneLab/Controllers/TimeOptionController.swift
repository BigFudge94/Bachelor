//
//  TimeOptionController.swift
//  HealthDroneLab
//
//  Created by Matias Marek on 26/12/2019.
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import UIKit

class TimeOptionController: UIViewController {
    
    
    @IBOutlet weak var onGoingButton: UIButton!
    @IBOutlet weak var plannedButton: UIButton!
    @IBOutlet weak var endedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad() }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if let identifier = segue.identifier {
            if let url = URLs.urlDictionary[identifier] {
                let destinationViewController = segue.destination as! DroneOverviewTableController
                destinationViewController.droneOperationURL = url
                destinationViewController.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
}
