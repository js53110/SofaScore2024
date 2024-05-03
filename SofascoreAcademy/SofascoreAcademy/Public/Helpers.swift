import Foundation
import UIKit


struct DateData {
    
    let dayOfWeek: String
    let dateString: String
    let fullDate: String
}


public enum Helpers {

    static func getMatchStatus(matchId: Int) -> MatchStatus {
        if let match = matches.first(where: { $0.matchId == matchId }) {
            let matchStatus = match.status
            return matchStatus
        }
        return .upcoming
    }
    

    static func determineMatchStatusString(matchStatus: MatchStatus) -> String {
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
    
    static func determineHomeTeamTextColorBasedOnMatchStatus(matchStatus: MatchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .black
        case .homeTeamWin:
            return .black
        case .awayTeamWin:
            return Colors.surfaceLv2
        case .draw:
            return Colors.surfaceLv2
        }
    }
    
    static func determineAwayTeamTextColorBasedOnMatchStatus(matchStatus: MatchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .black
        case .homeTeamWin:
            return Colors.surfaceLv2
        case .awayTeamWin:
            return .black
        case .draw:
            return Colors.surfaceLv2
        }
    }
    
    static func determineHomeTeamScoreColorBasedOnMatchStatus(matchStatus: MatchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .red
        case .homeTeamWin:
            return .black
        case .awayTeamWin:
            return Colors.surfaceLv2
        case .draw:
            return Colors.surfaceLv2
        }
    }
    
    static func determineAwayTeamScoreColorBasedOnMatchStatus(matchStatus: MatchStatus) -> UIColor {
        switch matchStatus {
        case .upcoming:
            return .black
        case .inProgress:
            return .red
        case .homeTeamWin:
            return Colors.surfaceLv2
        case .awayTeamWin:
            return .black
        case .draw:
            return Colors.surfaceLv2
        }
    }
    
    static func clearStackView(stackView: UIStackView) {
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    static func determineDataForDisplay(sportSlug : SportSlug) -> Array<LeagueInfo> {
        switch sportSlug {
        case .football:
            return leaguesData1
        case .basketball:
            return leaguesData2
        case .americanFootball:
            return leaguesData3
        }
    }
    
    
    static func getDataForDateCell(index: Int) -> DateData {
        let currentDate = Date()
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -7 + index
        guard let date = calendar.date(byAdding: dateComponents, to: currentDate) else {
            fatalError("Failed to calculate date")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = if(index != 7) {
            dateFormatter.string(from: date).prefix(3).uppercased()
        } else {
            "TODAY"
        }
        
        dateFormatter.dateFormat = "dd.MM." 
        let dateString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fullDate = dateFormatter.string(from: date)
        
        return DateData(dayOfWeek: dayOfWeek, dateString: dateString, fullDate: fullDate)
    }
    
    
}
