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
    
    func getCoachImageApi(coachId: Int) async -> Result<UIImage, NetworkError> {
        let urlString: String = "\(ApiClient.urlBase)/coach/\(coachId)/image"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            guard let coachImage = UIImage(data: data) else {
                return .failure(.invalidData)
            }
            
            return .success(coachImage)
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
    
    func getTeamData(teamId: Int) async -> Result<Team, NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let team = try JSONDecoder().decode(Team.self, from: data)
            return .success(team)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTeamPlayers(teamId: Int) async -> Result<[Player], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/players"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let teamPlayers = try JSONDecoder().decode([Player].self, from: data)
            return .success(teamPlayers)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTeamTournaments(teamId: Int) async -> Result<[Tournament], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/tournaments"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let teamTournaments = try JSONDecoder().decode([Tournament].self, from: data)
            return .success(teamTournaments)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTeamNextMatches(teamId: Int) async -> Result<[Event], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/events/next/0"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let nextEvent = try JSONDecoder().decode([Event].self, from: data)
            return .success(nextEvent)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTeamLastMatches(teamId: Int) async -> Result<[Event], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/team/\(teamId)/events/last/0"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let nextEvent = try JSONDecoder().decode([Event].self, from: data)
            return .success(nextEvent)
        } catch {
            return .failure(.invalidData)
        }
    }
}
