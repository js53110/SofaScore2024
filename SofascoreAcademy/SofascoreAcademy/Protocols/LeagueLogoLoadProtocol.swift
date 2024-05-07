import UIKit
protocol LeagueLogoLoadDelegate: AnyObject {
    
    func fetchLeagueLogoFromApi(tournamentId: Int, section: Int)
}
