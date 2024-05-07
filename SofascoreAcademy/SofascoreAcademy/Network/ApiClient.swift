import Foundation
import UIKit
import Network

enum ApiError: Error {
    case invalidData
    case invalidURL
}

class ApiClient {
    
    static let baseURLString = "https://static-api.sofascore.dev/api/event/"
    let eventID = 11352380
    
    
    func getEventDataOld(completionHandler: @escaping (Result<EventDataResponse, Error>) -> Void) {
        let urlString = "\(ApiClient.baseURLString)\(eventID)"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ApiError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession
            .shared
            .dataTask(with: request) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(ApiError.invalidData))
                return
            }
            
            do {
                let eventDataResponse = try JSONDecoder().decode(EventDataResponse.self, from: data)
                completionHandler(.success(eventDataResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func getEventDataNew() async -> Result<EventDataResponse, Error> {
        let urlString = "\(ApiClient.baseURLString)\(eventID)"
        guard let url = URL(string: urlString) else {
            return .failure(ApiError.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession
                .shared
                .data(for: request)
            let eventDataResponse = try JSONDecoder().decode(EventDataResponse.self, from: data)
            return .success(eventDataResponse)
        } catch {
            return .failure(error)
        }
    }
    
    
}
