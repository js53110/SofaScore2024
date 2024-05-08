import Foundation

struct Team: Codable {
    
    let name: String
    let slug: String
    let shortName: String
    let gender: String
    let nameCode: String
    let disabled: Bool
    let national: Bool
    let id: Int
    let teamColors: TeamColors
}
