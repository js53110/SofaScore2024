import Foundation

enum GoalType: String, Codable {
    case regular = "regular"
    case ownGoal = "owngoal"
    case penalty = "penalty"
    case onePoint = "onepoint"
    case twoPoint = "twopoint"
    case threePoint = "threepoint"
    case touchdown = "touchdown"
    case safety = "safety"
    case fieldGoal = "fieldgoal"
    case extraPoint = "extrapoint"
}



struct FootballIncident: Codable {
    
    let player: Player?
    let type: String
    let teamSide: String?
    let color: String?
    let id: Int
    let time: Int
    let scoringTeam: String?
    let homeScore: Int?
    let awayScore: Int?
    let goalType: String?
}
