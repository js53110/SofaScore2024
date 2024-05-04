struct Tournament: Codable {
    
    let id: Int
    let name: String
    let slug: String
    let sport: Sport
    let country: Country
}
