import Foundation

enum UserDefaultsService {
    static func saveDataToUserDefaults(sportSlug: sportSlug) {
        
        let stringValue = sportSlugToString(sportSlug)
        UserDefaults.standard.set(stringValue, forKey: "sportSlug")
    }
    
    static func retrieveDataFromUserDefaults() -> sportSlug {
        
        guard let stringValue = UserDefaults.standard.string(forKey: "sportSlug"),
              let sport = stringToSportSlug(stringValue) else {
            print("No SportSlug data found in UserDefaults.")
            return .football // Default sportSlug
        }
        print("Loaded sportSlug: \(sport)")
        return sport
    }
    
    static func sportSlugToString(_ sportSlug: sportSlug) -> String {
        
        switch sportSlug {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "americanFootball"
        }
    }
    
    static func stringToSportSlug(_ stringValue: String) -> sportSlug? {
        
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
