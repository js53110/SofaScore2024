import UIKit
protocol TeamLogoLoadProtocol: AnyObject {
    
    func fetchTeamsLogosFromApi(homeTeamId: Int, awayTeamId: Int, indexPath: IndexPath)
}
