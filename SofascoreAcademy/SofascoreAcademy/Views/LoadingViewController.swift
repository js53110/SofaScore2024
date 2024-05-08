import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    private let apiClient = ApiClient()
    let eventID = 11352380

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataNew(eventID: eventID)
        fetchDataOld(eventID: eventID)
    }
    
    func fetchDataNew(eventID: Int) {
        Task {
            do {
                let eventDataResult = await apiClient.getEventDataNew(eventID: eventID)
                switch eventDataResult {
                case .success(let eventData):
                    handleSuccess(eventData: eventData)
                case .failure(let error):
                    handleFailure(error: error)
                }
            }
        }
    }
    
    func fetchDataOld(eventID: Int) {
        ApiClient().getEventDataOld(eventID: eventID) { result in
            switch result {
            case .success(let eventData):
                self.handleSuccess(eventData: eventData)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func handleSuccess(eventData: EventDataResponse) {
        for tournament in eventData.game.tournaments {
            print(tournament.category.name)
            print(tournament.tournament.name)
            print(tournament.events.first?.homeTeam.name ?? "")
            print(tournament.events.first?.awayTeam.name ?? "")
        }
    }
    
    func handleFailure(error: Error) {
        print("Error fetching data: \(error.localizedDescription)")
    }
}
