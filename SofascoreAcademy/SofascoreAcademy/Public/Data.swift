import Foundation

enum MatchStatus {
    case notstarted
    case inProgress
    case homeTeamWin
    case awayTeamWin
    case draw
}

enum SportSlug {
    case football
    case basketball
    case americanFootball
    
    var title: String {
        switch self {
        case .football:
            return "Football"
        case .basketball:
            return "Basketball"
        case .americanFootball:
            return "Am. Football"
        }
    }
    
    var logo: String {
        switch self {
        case .football:
            return "icon_football"
        case .basketball:
            return "icon_basketball"
        case .americanFootball:
            return "icon_american_football"
        }
    }
}

struct ParsedData {
    let key: Int
    let value: LeagueData
}

struct LeagueData {
    let name: String
    let slug: String
    let country: String
    let id: Int
    let events: [Event]
}

var footballData: [LeagueData] = []
var basketballData: [LeagueData] = []
var americanFootballData: [LeagueData] = []

//var footballIncidents = []
