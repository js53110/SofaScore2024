import Foundation
import UIKit
import Network

class ApiClient {
    
    func getEventDataNew(sportSlug: SportSlug, date: String) async throws -> [Event] {
                
        let urlString = "https://academy-backend.sofascore.dev/sport/\(sportSlug)/events/\(date)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        
        let eventResponse = try JSONDecoder().decode([Event].self, from: data)
        return eventResponse
    }
}

