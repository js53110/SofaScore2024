import Foundation
import UIKit

public enum helpers {

    static func getMatchStatus(matchId: Int) -> matchStatus {
        if let match = matches.first(where: { $0.matchId == matchId }) {
            let matchStatus = match.status
            return matchStatus
        }
        return .upcoming
    }

    static func determineMatchStatusString(matchStatus: matchStatus) -> String {
        switch matchStatus {
        case .homeTeamWin :
            return "FT"
        case .awayTeamWin :
            return "FT"
        case .draw :
            return "FT"
        case .inProgress :
            return "37'" // Updating time in ViewController
        default:
            return "-"
        }
    }

    static func convertTimestampToTime(timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        return timeString
    }
    
    static func determineHomeTeamTextColorBasedOnMatchStatus(matchStatus: matchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .black
        case .homeTeamWin:
            return .black
        case .awayTeamWin:
            return colors.surfaceLv2
        case .draw:
            return colors.surfaceLv2
        }
    }
    
    static func determineAwayTeamTextColorBasedOnMatchStatus(matchStatus: matchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .black
        case .homeTeamWin:
            return colors.surfaceLv2
        case .awayTeamWin:
            return .black
        case .draw:
            return colors.surfaceLv2
        }
    }
    
    static func determineHomeTeamScoreColorBasedOnMatchStatus(matchStatus: matchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .red
        case .homeTeamWin:
            return .black
        case .awayTeamWin:
            return colors.surfaceLv2
        case .draw:
            return colors.surfaceLv2
        }
    }
    
    static func determineAwayTeamScoreColorBasedOnMatchStatus(matchStatus: matchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .red
        case .homeTeamWin:
            return colors.surfaceLv2
        case .awayTeamWin:
            return .black
        case .draw:
            return colors.surfaceLv2
        }
    }
    
    static func clearStackView(stackView: UIStackView) {
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    static func determineDataForDisplay(sportSlug : sportSlug) -> Array<LeagueInfo> {
        switch sportSlug {
        case .football:
            return leaguesData1
        case .basketball:
            return leaguesData2
        case .americanFootball:
            return leaguesData3
        }
    }
    
    static func determineTabButtonData(sportSlug: sportSlug) -> (String, String) {
        switch sportSlug {
        case .football:
            return ("Icon", "Football")
        case .basketball:
            return ("icon_basketball", "Basketball")
        case .americanFootball:
            return ("icon_american_football", "Am. Football")
        }
    }
}
