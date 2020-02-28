//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation

struct URLs {
    
    
    static let baseURL = "https://healthdrone.unifly.tech/api/"
    
    // Expires estimate 12 hours.
    static let acessToken =  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFja2luZ0FsdGl0dWRlRmlsdGVyIjo0MDAwLjAsImF1ZCI6WyJ1c2VyTWFuYWdlbWVudFNlcnZpY2UiXSwiY2hhbm5lbHMiOlsiXCJvcGVyYXRvcjpiMjM1NGFjNS1kMGQ2LTRhYTktOTQ0NC1lNThmYjI0MjdlMTBcIjpbXCJzdWJzY3JpYmVcIl0iLCJcIm9wZXJhdG9yOmIyMzU0YWM1LWQwZDYtNGFhOS05NDQ0LWU1OGZiMjQyN2UxMDoqXCI6W1wic3Vic2NyaWJlXCJdIiwiXCJvcGVyYXRvcjpiMjM1NGFjNS1kMGQ2LTRhYTktOTQ0NC1lNThmYjI0MjdlMTA6dWFzOipcIjpbXCJzdWJzY3JpYmVcIl0iLCJcImZsaWdodFwiOltcInN1YnNjcmliZVwiXSIsIlwibmVhcmJ5OipcIjpbXCJzdWJzY3JpYmVcIl0iLCJcImFkc2I6bmVhcmJ5OipcIjpbXCJzdWJzY3JpYmVcIl0iLCJcImFkc2JcIjpbXCJzdWJzY3JpYmVcIl0iXSwidXNlcl9uYW1lIjoiTU1BUkUxNUBTVFVERU5ULlNEVS5ESyIsInNjb3BlIjpbInJlYWQiXSwiZXhwIjoxNTgyOTQzOTI0LCJqdGkiOiJkMmQ2ZTUyMi02OTdkLTQ5MTEtODkyZC0zMDM5YWRkNTlmNmUiLCJjbGllbnRfaWQiOiJzZHVIZWFsdGhEcm9uZUNvbm5lY3QiLCJ1c2lkIjoiZjVlN2VhZjItYjJkMS00OTdhLTljZTUtMDIwMjVkZjFmMGM5In0.mZSJehkxk6s4oSsHLTLfEeRYaO0l45f4zbqaEUEuaqs"
    
    
    static var urlDictionary: Dictionary<String,URL> = {
        let urlStrings = [
            "Operations; past" : "\(baseURL)users/me/uasoperations?limit=10&start=0&startDate=past",
            "Operation Details" : "\(baseURL)uasoperations/",
            "Operations; current and future" : "https://healthdrone.unifly.tech/api/users/me/uasoperations?limit=10&start=0&startDate=future",
            "Flights in all Operations" : "\(baseURL)uasoperations/flights"
        ]
        var urls = Dictionary<String,URL>()
        for(key, value) in urlStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
    
}
