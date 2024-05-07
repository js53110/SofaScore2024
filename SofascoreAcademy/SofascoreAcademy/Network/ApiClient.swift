import Foundation
import UIKit
import Network

class ApiClient {
    
    static let urlBase = "https://academy-backend.sofascore.dev"

    func getEventDataNew(sportSlug: SportSlug, date: String) async throws -> [Event] {
        let slugString: String = Helpers.getSlugStringFromEnum(sportSlug: sportSlug)
                
        let urlString: String = "\(ApiClient.urlBase)/sport/\(slugString)/events/\(date)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let eventResponse = try JSONDecoder().decode([Event].self, from: data)
            return eventResponse
        } catch {
            throw error
        }
    }
    
    func getLeagueLogoApi(tournamentId: Int) async throws -> UIImage? {
        let cacheKey: String = "league_\(tournamentId)"
        
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            return cachedImage
        }
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)/image"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let logoImage = UIImage(data: data) else {
                return nil
            }
            
            ImageCache.shared.setImage(logoImage, forKey: cacheKey)
            return logoImage
        } catch {
            throw error
        }
    }

    func getTeamLogoApi(teamId: Int) async throws -> UIImage? {
        let cacheKey: String = "team_\(teamId)"
        
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            return cachedImage
        }
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/image"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let logoImage = UIImage(data: data) else {
                return nil
            }
            
            ImageCache.shared.setImage(logoImage, forKey: cacheKey)
            return logoImage
        } catch {
            throw error
        }
    }
}
