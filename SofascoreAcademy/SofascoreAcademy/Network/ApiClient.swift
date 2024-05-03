import Foundation
import UIKit
import Network

class ApiClient {
    
    func getEventDataOld(completionHandler: @escaping ((EventDataResponse)?) -> Void){
    let urlString = "https://static-api.sofascore.dev/api/event/11352380"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared
            .dataTask(with: request) {data, _, _ in
                if let data,
                   let eventDataResponse = try? JSONDecoder().decode(EventDataResponse.self, from: data) {
                    completionHandler(eventDataResponse)
                } else {
                    completionHandler(nil)
                }
            }
        task.resume()
    }
    
    func getEventDataNew() async throws -> EventDataResponse? {
        
        let urlString = "https://static-api.sofascore.dev/api/event/11352380"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let eventDataResponse = try JSONDecoder().decode(EventDataResponse.self, from: data)
        return eventDataResponse
    }
}

