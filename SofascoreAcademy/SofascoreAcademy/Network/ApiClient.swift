import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

enum ApiError: Error {
    case invalidData
    case invalidURL
}

class ApiClient {
    
    static let shared = ApiClient()
    static let urlBase = "https://academy-backend.sofascore.dev"
    private let urlSession = URLSession.shared
    private let imageCache = ImageCache.shared
    
    func getDataForSport(sportSlug: SportSlug, date: String) async -> Result<[Event], NetworkError> {
        let slugString: String = Helpers.getSlugStringFromEnum(sportSlug: sportSlug)
        
        let urlString: String = "\(ApiClient.urlBase)/sport/\(slugString)/events/\(date)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
            
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let eventResponse = try JSONDecoder().decode([Event].self, from: data)
            return .success(eventResponse)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getLeagueLogoApi(tournamentId: Int) async -> Result<UIImage, NetworkError> {
        let cacheKey: String = "league_\(tournamentId)"
        
        if let cachedImage = imageCache.image(forKey: cacheKey) {
            return .success(cachedImage)
        }
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)/image"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            guard let logoImage = UIImage(data: data) else {
                return .failure(.invalidData)
            }
            
            imageCache.setImage(logoImage, forKey: cacheKey)
            return .success(logoImage)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTeamLogoApi(teamId: Int) async -> Result<UIImage, NetworkError> {
        let cacheKey: String = "team_\(teamId)"
        
        if let cachedImage = imageCache.image(forKey: cacheKey) {
            return .success(cachedImage)
        }
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/image"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            guard let logoImage = UIImage(data: data) else {
                return .failure(.invalidData)
            }
            
            imageCache.setImage(logoImage, forKey: cacheKey)
            return .success(logoImage)
        } catch {
            return .failure(.invalidData)
        }
    }
}
