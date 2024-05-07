import Foundation
import UIKit


struct DateData {
    
    let dayOfWeek: String
    let dateString: String
    let fullDate: String
}

public enum Helpers {
    
    //MARK: Date Functions
    static func convertTimestampToTime(timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        return timeString
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
    
    static func getTodaysDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    static func getDateAndDayFromString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
            
            if components.day != nil {
                let dayOfWeekNumber = calendar.component(.weekday, from: date)
                let dayOfWeekString = dateFormatter.weekdaySymbols[dayOfWeekNumber - 1].prefix(3)
                
                if calendar.isDateInToday(date) {
                    return "Today"
                } else {
                    let dateFormatterOutput = DateFormatter()
                    dateFormatterOutput.dateFormat = "dd.MM.yyyy"
                    let formattedDate = dateFormatterOutput.string(from: date)
                    
                    return "\(dayOfWeekString), \(formattedDate)"
                }
            }
        }
        
        return "Invalid date format"
    }
    
    //MARK: Data Functions
    static func determineDataForDisplay(sportSlug : SportSlug) -> Array<LeagueData> {
        switch sportSlug {
        case .football:
            return footballData
        case .basketball:
            return basketballData
        case .americanFootball:
            return americanFootballData
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
        var groupedEvents: [Int: (name: String, slug: String, country: String, id: Int, events: [Event])] = [:]
        
        for event in eventsData {
            let tournamentID = event.tournament.id
            let tournamentName = event.tournament.name
            let tournamentSlug = event.tournament.slug
            let tournamentCountry = event.tournament.country.name
            
            if var tournamentEntry = groupedEvents[tournamentID] {
                tournamentEntry.events.append(event)
                groupedEvents[tournamentID] = tournamentEntry
            } else {
                groupedEvents[tournamentID] = (name: tournamentName, slug: tournamentSlug, country: tournamentCountry, id: tournamentID, events: [event])
            }
        }
        
        let groupedEventsArray = groupedEvents.values.map { eventData in
            return LeagueData(name: eventData.name, slug: eventData.slug, country: eventData.country, id: eventData.id, events: eventData.events)
        }
        
        return groupedEventsArray
    }
    
    static func getEventsCount(data: Array<LeagueData>) -> Int {
        var count = 0;
        for tournament in data {
            for _ in tournament.events {
                count = count + 1
            }
        }
        return count
    }
    
    //MARK: MatchStatus Functions
    static func determineMatchStatusString(matchStatus: String) -> String {
        switch matchStatus {
        case "finished" :
            return "FT"
        case "inprogress" :
            return "x" //todo: get match minute
        default:
            return "-"
        }
    }
    
    static func determineHomeTeamTextColorBasedOnMatchStatus(matchWinner: String?) -> UIColor {
        switch matchWinner {
        case "away":
            return Colors.surfaceLv2
        case "draw":
            return Colors.surfaceLv2
        default:
            return .black
        }
        
    }
    
    static func determineAwayTeamTextColorBasedOnMatchStatus(matchWinner: String?) -> UIColor {
        switch matchWinner {
        case "home":
            return Colors.surfaceLv2
        case "draw":
            return Colors.surfaceLv2
        default:
            return .black
        }
    }
    
    static func determineHomeTeamScoreColorBasedOnMatchStatus(matchStatus: String) -> UIColor {
        switch matchStatus {
        case "inprogress":
            return Colors.red
        case "draw":
            return Colors.surfaceLv2
        default:
            return .black
        }
    }
    
    static func determineAwayTeamScoreColorBasedOnMatchStatus(matchStatus: String) -> UIColor {
        switch matchStatus {
        case "inprogress":
            return Colors.red
        case "draw":
            return Colors.surfaceLv2
        default:
            return .black
        }
    }
    
    static func getSlugStringFromEnum(sportSlug: SportSlug) -> String{
        switch sportSlug {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "american-football"
        }
    }
}
