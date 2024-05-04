import Foundation
import UIKit
import Network

class ApiClient {
    
    func getEventDataNew(sportSlug: SportSlug, date: String) async throws -> [Event] {
        
        let slugString: String
        
        switch sportSlug {
        case .football:
            slugString = "football"
        case .basketball:
            slugString = "basketball"
        case .americanFootball:
            slugString = "american-football"
        }
                
        let urlString = "https://academy-backend.sofascore.dev/sport/\(slugString)/events/\(date)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let eventResponse = try JSONDecoder().decode([Event].self, from: data)
        return eventResponse
    }
}

