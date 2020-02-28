//
//  HealthDroneLabTests.swift
//  HealthDroneLabTests
//
//  Created by Matias Marek on 13/11/2019.
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import XCTest
@testable import HealthDroneLab

class HealthDroneLabTests: XCTestCase {
    
    func testHelloWorld() {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }
    
    /*Found Bug in init forgotten break */
    func testInitializerSvendborg() {
        let testHospital = Hospital(name: "Svendborg")
        //This means that it does not work as intendet
        //testHospital.setDefaultHospital(hospitalName: "Svendborg")
        XCTAssertEqual(testHospital.getLongtiude(), 10.605734)
    }
    
    func testInitializerÆrø() {
        let testHospital = Hospital(name: "Ærø")
        //This means that it does not work as intendet
        //testHospital.setDefaultHospital(hospitalName: "Svendborg")
        XCTAssertEqual(testHospital.getLongtiude(), 10.406590)
    }
    
    func testInitializerOdense() {
        let testHospital = Hospital(name: "Odense")
        //This means that it does not work as intendet
        //testHospital.setDefaultHospital(hospitalName: "Svendborg")
        XCTAssertEqual(testHospital.getLongtiude(), 10.367734)
    }
    
    
    func testGetLongitude() {
        let hospital = Hospital(name: "Sønderborg")
        XCTAssertEqual(hospital.getHospitalName(), "Svendborg")
    }


    override func setUp() {
        
    }
    
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
