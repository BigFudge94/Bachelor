//
//  Credentials.swift
//  HealthDroneLab
//
//  Created by Matias Marek on 18/11/2019.
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation

let headers = [
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept": "application/json",
    "Authorization": "Basic c2R1SGVhbHRoRHJvbmVDb25uZWN0OnNkdTIwMTkwM0hlYWx0aERyb25l",
    "User-Agent": "PostmanRuntime/7.19.0",
    "Cache-Control": "no-cache",
    "Postman-Token": "e361c42c-349c-4039-83e4-d2a15c65c723,b39152f4-7f5d-4be2-b7a9-03698afa1abf",
    "Host": "healthdrone.unifly.tech",
    "Accept-Encoding": "gzip, deflate",
    "Content-Length": "75",
    "Connection": "keep-alive",
    "cache-control": "no-cache"
]

let postData = NSMutableData(data: "username=mmare15@student.sdu.dk".data(using: String.Encoding.utf8)!)
postData.append("&password=DroneTest123".data(using: String.Encoding.utf8)!)
postData.append("&grant_type=password".data(using: String.Encoding.utf8)!)

let request = NSMutableURLRequest(url: NSURL(string: "https://healthdrone.unifly.tech/oauth/token")! as URL,
                                  cachePolicy: .useProtocolCachePolicy,
                                  timeoutInterval: 10.0)
request.httpMethod = "POST"
request.allHTTPHeaderFields = headerseba
request.httpBody = postData as Data

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    if (error != nil) {
        print(error)
    } else {
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse)
    }
})

dataTask.resume()



