import Foundation

struct Player: Codable {
    
    let id: Int
    let name: String
    let slug: String
    let country: Country
    let position: String
}
