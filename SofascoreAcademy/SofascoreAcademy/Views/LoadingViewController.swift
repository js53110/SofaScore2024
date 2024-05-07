import Foundation
import UIKit

class LoadingViewController: UIViewController {

    private let apiClient = ApiClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        Task {
            do {
                let eventDataResult = await apiClient.getEventDataNew()
                switch eventDataResult {
                case .success(let eventData):
                    handleSuccess(eventData: eventData)
                case .failure(let error):
                    handleFailure(error: error)
                }
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
