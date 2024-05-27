import Foundation

protocol TeamLogoLoadProtocol: AnyObject {
    
    func fetchTeamsLogosFromApi(homeTeamId: Int, awayTeamId: Int, indexPath: IndexPath)
}
