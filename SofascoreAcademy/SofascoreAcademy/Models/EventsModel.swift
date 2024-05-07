struct Event: Codable {
    
    let id: Int
    let slug: String
    let tournament: Tournament
    let homeTeam: Team
    let awayTeam: Team
    let status: String
    let startDate: String
    let homeScore: Score
    let awayScore: Score
    let winnerCode: String?
    let round: Int
}
