struct Tournaments: Codable {
    
    let tournament: Tournament
    let category: Category
    let season: Season
    let hasEventPlayerStatistics: Bool
    let hasEventPlayerHeatMap: Bool?
    let hasBoxScore: Bool?
    let displayInverseHomeAwayTeams: Bool
    let events: [Events]
}
