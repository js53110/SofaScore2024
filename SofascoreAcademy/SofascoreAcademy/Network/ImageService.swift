import Foundation
import UIKit

class ImageService {
    
    private let imageCache = ImageCache.shared
    
    func getLeagueLogo(tournamentId: Int) async -> UIImage {
        
        let cacheKey: String = "league_\(tournamentId)"
        
        if let cachedImage = imageCache.getImage(forKey: cacheKey) {
            return cachedImage
        } else {
            let imageResult = await ApiClient().getLeagueLogoApi(tournamentId: tournamentId)
            switch imageResult {
            case .success(let leagueLogo):
                imageCache.setImage(leagueLogo, forKey: cacheKey)
                return leagueLogo
            case .failure:
                return UIImage(named: "placeholder") ?? UIImage()
            }
        }
    }
    
    func getTeamLogo(teamId: Int) async -> UIImage {
        
        let cacheKey: String = "team_\(teamId)"
        
        if let cachedImage = imageCache.getImage(forKey: cacheKey) {
            return cachedImage
        } else {
            let imageResult = await ApiClient().getTeamLogoApi(teamId: teamId)
            switch imageResult {
            case .success(let teamLogo):
                imageCache.setImage(teamLogo, forKey: cacheKey)
                return teamLogo
            case .failure:
                return UIImage(named: "placeholder") ?? UIImage()
            }
        }
    }
    
    func getCountryFlag(countryId: Int) async -> UIImage {
        switch countryId {
        case 56:
            return UIImage(named: "croatia_flag") ?? UIImage()
        case 70:
            return UIImage(named: "england_flag") ?? UIImage()
        case 218:
            return UIImage(named: "spain_flag") ?? UIImage()
        case 239:
            return UIImage(named: "usa_flag") ?? UIImage()
        default:
            return UIImage(named: "placeholder") ?? UIImage()
        }
    }
    
    func getCoachImage(coachId: Int) async -> UIImage {
        
        let cacheKey: String = "coach_\(coachId)"
        
        if let cachedImage = imageCache.getImage(forKey: cacheKey) {
            return cachedImage
        } else {
            let imageResult = await ApiClient().getCoachImageApi(coachId: coachId)
            switch imageResult {
            case .success(let teamLogo):
                imageCache.setImage(teamLogo, forKey: cacheKey)
                return teamLogo
            case .failure:
                return UIImage(named: "person_placeholder") ?? UIImage()
            }
        }
    }
    
    func getPlayerImage(playerId: Int) async -> UIImage {
        
        let cacheKey: String = "player_\(playerId)"
        
        if let cachedImage = imageCache.getImage(forKey: cacheKey) {
            return cachedImage
        } else {
            let imageResult = await ApiClient().getPlayerImageApi(playerId: playerId)
            switch imageResult {
            case .success(let teamLogo):
                imageCache.setImage(teamLogo, forKey: cacheKey)
                return teamLogo
            case .failure:
                return UIImage(named: "person_placeholder") ?? UIImage()
            }
        }
    }
}
