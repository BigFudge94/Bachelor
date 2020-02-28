//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation


struct Resource<A> {
    
    var urlRequest: URLRequest
    
    let parse: (Data) -> A?
}


extension Resource where A: Decodable {
    
    init(get url: URL) {
        self.urlRequest = URLRequest(url: url)
        urlRequest.addValue(URLs.acessToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
    
    init<Body: Encodable>(url: URL, method: HttpMethod<Body>) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.method
        
        
        switch method {
        case .get: ()
        case .post(let body):
            urlRequest.addValue(URLs.acessToken, forHTTPHeaderField: "Authorization")
        
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            self.urlRequest.httpBody = try! JSONEncoder().encode(body)
        }
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
        
    }
}

