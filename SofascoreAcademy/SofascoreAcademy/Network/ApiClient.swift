import Foundation
import UIKit
import Network

class ApiClient {
    
    static let urlBase = "https://academy-backend.sofascore.dev"

    func getEventDataNew(sportSlug: SportSlug, date: String) async throws -> [Event] {
        let slugString: String = Helpers.getSlugStringFromEnum(sportSlug: sportSlug)
                
        let urlString: String = "\(ApiClient.urlBase)/sport/\(slugString)/events/\(date)"
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let eventResponse = try JSONDecoder().decode([Event].self, from: data)
        return eventResponse
    }
    
    func getLeagueLogoApi(tournamentId: Int) async throws -> UIImage? {
        let cacheKey: String = "league_\(tournamentId)"
        
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            return cachedImage
        }
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)/image"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let logoImage: UIImage = UIImage(data: data) {
                ImageCache.shared.setImage(logoImage, forKey: cacheKey)
                return logoImage
            } else {
                return nil
            }
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
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let logoImage: UIImage = UIImage(data: data) {
                ImageCache.shared.setImage(logoImage, forKey: cacheKey)
                return logoImage
            } else {
                return nil
            }
        } catch {
            throw error
        }
    }
}
