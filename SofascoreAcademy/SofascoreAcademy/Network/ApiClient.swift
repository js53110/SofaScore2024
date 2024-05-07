import Foundation
import UIKit
import Network

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

class ApiClient {
    
    static let urlBase = "https://academy-backend.sofascore.dev"
    
    func getDataForSportWithCH(sportSlug: SportSlug, date: String, completionHandler: @escaping (Result<[Event], Error>) -> Void) {
        let slugString: String = Helpers.getSlugStringFromEnum(sportSlug: sportSlug)
        
        let urlString: String = "\(ApiClient.urlBase)/sport/\(slugString)/events/\(date)"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let eventResponse = try JSONDecoder().decode([Event].self, from: data)
                completionHandler(.success(eventResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }

    
    func getDataForSport(sportSlug: SportSlug, date: String) async throws -> [Event] {
        let slugString: String = Helpers.getSlugStringFromEnum(sportSlug: sportSlug)
        
        let urlString: String = "\(ApiClient.urlBase)/sport/\(slugString)/events/\(date)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let eventResponse = try JSONDecoder().decode([Event].self, from: data)
            return eventResponse
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func getLeagueLogoApi(tournamentId: Int) async throws -> UIImage? {
        let cacheKey: String = "league_\(tournamentId)"
        
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            return cachedImage
        }
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)/image"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let logoImage = UIImage(data: data) else {
                throw NetworkError.invalidData
            }
            
            ImageCache.shared.setImage(logoImage, forKey: cacheKey)
            return logoImage
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func getTeamLogoApi(teamId: Int) async throws -> UIImage? {
        let cacheKey: String = "team_\(teamId)"
        
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            return cachedImage
        }
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/image"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let logoImage = UIImage(data: data) else {
                throw NetworkError.invalidData
            }
            
            ImageCache.shared.setImage(logoImage, forKey: cacheKey)
            return logoImage
        } catch {
            throw NetworkError.invalidData
        }
    }
}
