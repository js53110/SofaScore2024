import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

//enum FootballIncidentType { // TO DO
//    case footballGoal(FootballGoal)
//    case footballCard(FootballCard)
//    case footballPeriod(FootballPeriod)
//}

class ApiClient {
    
    static let shared = ApiClient()
    static let urlBase = "https://academy-backend.sofascore.dev"
    private let urlSession = URLSession.shared
    private let imageCache = ImageCache.shared
    
    func getData(sportSlug: SportSlug, date: String) async -> Result<[Event], NetworkError> {
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
            
            return .success(logoImage)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTeamLogoApi(teamId: Int) async -> Result<UIImage, NetworkError> {
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
            
            return .success(logoImage)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getFootballIncidents(eventId: Int) async -> Result<[FootballIncident], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/event/\(eventId)/incidents"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let eventIncidents = try JSONDecoder().decode([FootballIncident].self, from: data)
            return .success(eventIncidents)
        } catch {
            return .failure(.invalidData)
        }
    }
}
