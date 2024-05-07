import Foundation

struct EventDataResponse: Codable {
    
    let createdByNickname: String?
    let eventEditorName: String?
    let hasStandings: Bool
    let hasCupTree: Bool
    let hasIncidents: Bool
    let hasHighlights: Bool
    let hasHighlightsStream: Bool
    let game: Game
    let vote: Vote
    let hasStatistics: Bool
    let hasComments: Bool
    let hasInnings: Bool
    let hasLineups: Bool
    let hasOdds: Bool
    let hasTvChannels: Bool
    let hasLineupsImage: Bool
}
