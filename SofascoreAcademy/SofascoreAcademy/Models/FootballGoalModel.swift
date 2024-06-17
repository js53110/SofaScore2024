import Foundation

struct FootballGoal: Codable {
    
    let player: Player
    let scoringTeam: String
    let homeScore: Int
    let awayScore: Int
    let goalType: Int
    let id: Int
    let time: Int
    let type: String
}
