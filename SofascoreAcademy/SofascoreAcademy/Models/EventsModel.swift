import Foundation

struct Events: Codable {
    
    let roundInfo: RoundInfo
    let customId: String
    let status: Status
    let venue: Venue
    let homeTeam: Team
    let awayTeam: Team
    let hasHighlights: Bool
    let hasHighlightsStream: Bool
    let hasGlobalHighlights: Bool
    let id: Int
    let cardsCode: String
    let defaultPeriodCount: Int
    let defaultPeriodLength: Int
    let statusDescription: String
    let startTimestamp: Int
    let webUrl: String
    let fbPostId: String
    let hasTime: Bool
    let resultOnly: Bool
    let showEventNote: Bool
    let bet365Links: Bet365Links
}
