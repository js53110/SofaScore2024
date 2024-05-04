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
        return .notstarted
    }
    

    static func determineMatchStatusString(matchStatus: String) -> String {
        switch matchStatus {
//        case .homeTeamWin :
//            return "FT"
//        case .awayTeamWin :
//            return "FT"
//        case .draw :
//            return "FT"
//        case .inProgress :
//            return "37'" // Updating time in ViewController
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
        case .notstarted:
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
        case .notstarted:
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
        case .notstarted:
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
        case .notstarted:
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
    
    static func determineDataForDisplay(sportSlug : SportSlug) -> Array<LeagueData> {
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
    
    static func groupEventsByTournament(eventsData: [Event]) -> [LeagueData] {
        var groupedEvents: [Int: (name: String, slug: String, country: String, events: [Event])] = [:]

        var tempGroupedEvents: [Int: (name: String, slug: String, country: String, events: [Event])] = [:]

        for event in eventsData {
            let tournamentID = event.tournament.id
            let tournamentName = event.tournament.name
            let tournamentSlug = event.tournament.slug
            let tournamentCountry = event.tournament.country.name

            if var tournamentEntry = tempGroupedEvents[tournamentID] {
                tournamentEntry.events.append(event)
                tempGroupedEvents[tournamentID] = tournamentEntry
            } else {
                tempGroupedEvents[tournamentID] = (name: tournamentName, slug: tournamentSlug, country: tournamentCountry, events: [event])
            }
        }
        
        let groupedEventsArray = tempGroupedEvents.values.map { eventData in
            return LeagueData(name: eventData.name, slug: eventData.slug, country: eventData.country, events: eventData.events)
        }

        return groupedEventsArray
    }

    static func dateStringToTimestamp(_ dateString: String) -> TimeInterval? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        if let date = dateFormatter.date(from: dateString) {
            return date.timeIntervalSince1970
        } else {
            return nil
        }
    }





    
    
}
