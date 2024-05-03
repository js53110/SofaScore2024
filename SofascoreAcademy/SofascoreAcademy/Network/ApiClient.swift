import Foundation
import UIKit
import Network

class ApiClient {
    
//    func getEventDataOld(completionHandler: @escaping ((EventDataResponse)?) -> Void){
//    let urlString = "https://static-api.sofascore.dev/api/event/11352380"
//        var request = URLRequest(url: URL(string: urlString)!)
//        request.httpMethod = "GET"
//        
//        let task = URLSession.shared
//            .dataTask(with: request) {data, _, _ in
//                if let data,
//                   let eventDataResponse = try? JSONDecoder().decode(EventDataResponse.self, from: data) {
//                    completionHandler(eventDataResponse)
//                } else {
//                    completionHandler(nil)
//                }
//            }
//        task.resume()
//    }
    
    func getEventDataNew(sportSlug: SportSlug, date: String) async throws -> Event {
                
        let urlString = "https://academy-backend.sofascore.dev/sport/\(sportSlug)/events/\(date)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        
        let eventResponse = try JSONDecoder().decode(EventsResponse.self, from: data)
        return eventResponse.events
    }
}

