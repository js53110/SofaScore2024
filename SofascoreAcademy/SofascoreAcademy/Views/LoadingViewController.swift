import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    private let apiClient = ApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        apiClient.getEventDataOld { eventData in
        //            print(eventData ?? "No data found")
        //        }
        Task {
            let eventData = try await apiClient.getEventDataNew()
            if let eventData = eventData {
                for tournament in eventData.game.tournaments {
                    print(tournament.category.name)
                    print(tournament.tournament.name)
                    print(tournament.events.first?.homeTeam.name)
                    print(tournament.events.first?.awayTeam.name)
                }
            }
        }
    }
}
