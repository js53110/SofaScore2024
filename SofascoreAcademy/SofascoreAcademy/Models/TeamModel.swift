import Foundation

struct Team: Codable {
    
    let id: Int
    let name: String
    let country: Country
    let managerName: String?
    let venue: String?
}
