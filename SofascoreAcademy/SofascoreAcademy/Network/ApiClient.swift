import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

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
    
    func getLeaguesData(sportSlug: SportSlug) async -> Result<[Tournament], NetworkError> {
        let slugString: String = Helpers.getSlugStringFromEnum(sportSlug: sportSlug)
        
        let urlString: String = "\(ApiClient.urlBase)/sport/\(slugString)/tournaments/"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let tournamentsResponse = try JSONDecoder().decode([Tournament].self, from: data)
            return .success(tournamentsResponse)
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
    
    func getPlayerImageApi(playerId: Int) async -> Result<UIImage, NetworkError> {
        let urlString: String = "\(ApiClient.urlBase)/player/\(playerId)/image"
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
    
    func getFootballIncidents(eventId: Int) async -> Result<[EventIncident], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/event/\(eventId)/incidents"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let eventIncidents = try JSONDecoder().decode([EventIncident].self, from: data)
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
    
    func getTournamentData(tournamentId: Int) async -> Result<Tournament, NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let tournament = try JSONDecoder().decode(Tournament.self, from: data)
            return .success(tournament)
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
    
    func getTournamentNextMatches(tournamentId: Int) async -> Result<[Event], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)/events/next/0"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let event = try JSONDecoder().decode([Event].self, from: data)
            return .success(event)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getTournamentLastMatches(tournamentId: Int) async -> Result<[Event], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/tournament/\(tournamentId)/events/last/0"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let events = try JSONDecoder().decode([Event].self, from: data)
            return .success(events)
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
            let events = try JSONDecoder().decode([Event].self, from: data)
            return .success(events)
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
            let events = try JSONDecoder().decode([Event].self, from: data)
            return .success(events)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getPlayerDetails(playerId: Int) async -> Result<Player, NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/player/\(playerId)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let player = try JSONDecoder().decode(Player.self, from: data)
            return .success(player)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getPlayerNextMatches(playerId: Int) async -> Result<[Event], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/player/\(playerId)/events/next/0"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let event = try JSONDecoder().decode([Event].self, from: data)
            return .success(event)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    func getPlayerLastMatches(playerId: Int) async -> Result<[Event], NetworkError> {
        
        let urlString: String = "\(ApiClient.urlBase)/player/\(playerId)/events/last/0"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let event = try JSONDecoder().decode([Event].self, from: data)
            return .success(event)
        } catch {
            return .failure(.invalidData)
        }
    }
}
