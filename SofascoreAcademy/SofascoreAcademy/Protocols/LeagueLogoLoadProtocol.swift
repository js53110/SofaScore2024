import Foundation

protocol LeagueLogoLoadDelegate: AnyObject {
    
    func fetchLeagueLogoFromApi(tournamentId: Int, section: Int)
}
