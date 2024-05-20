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
                print("Error fetching league logo")
            }
        }
        return UIImage()
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
                print("Error fetching team logo")
            }
        }
        return UIImage()
    }
}
