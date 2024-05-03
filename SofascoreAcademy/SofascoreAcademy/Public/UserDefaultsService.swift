import Foundation

enum UserDefaultsService {
    
    static let sportSlugKey = "sportSlug"
    
    static func saveDataToUserDefaults(sportSlug: SportSlug) {
        let stringValue = sportSlugToString(sportSlug)
        UserDefaults.standard.set(stringValue, forKey: sportSlugKey)
    }
    
    static func retrieveDataFromUserDefaults() -> SportSlug {
        guard let stringValue = UserDefaults.standard.string(forKey: sportSlugKey),
              let sport = stringToSportSlug(stringValue) else {
            return .football // Default sportSlug
        }
        return sport
    }
    
    static func sportSlugToString(_ sportSlug: SportSlug) -> String {
        switch sportSlug {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "americanFootball"
        }
    }
    
    static func stringToSportSlug(_ stringValue: String) -> SportSlug? {
        switch stringValue {
        case "football":
            return .football
        case "basketball":
            return .basketball
        case "americanFootball":
            return .americanFootball
        default:
            return nil
        }
    }
}
