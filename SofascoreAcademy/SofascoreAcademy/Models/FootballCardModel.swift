import Foundation

struct FootballCard: Codable {
    
    let player: Player
    let teamSide: String
    let color: String
    let id: Int
    let time: Int
    let type: String
}
