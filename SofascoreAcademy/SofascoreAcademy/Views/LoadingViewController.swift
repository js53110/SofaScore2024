import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LoadingViewController: UIViewController {
    
    private let apiClient = ApiClient()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        addViews()
    }
    
    func addViews() {
        let mainVC = MainViewController()
        customAddChild(child: mainVC, parent: view, animation: nil)
    }
}

extension LoadingViewController {
    
    func displayEventsForCurrentDate(selectedDate: String)  {
        Task {
            do {
                let requestDataFootball = try await ApiClient().getDataForSport(sportSlug: .football, date: selectedDate)
                let requestDataBasketball = try await ApiClient().getDataForSport(sportSlug: .basketball, date: selectedDate)
                let requestDataAmFootball = try await ApiClient().getDataForSport(sportSlug: .americanFootball, date: selectedDate)
                
                let dataFootball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataFootball)
                let dataBasketball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataBasketball)
                let dataAmFootball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataAmFootball)
                
                footballData = dataFootball
                basketballData = dataBasketball
                americanFootballData = dataAmFootball
                
                setupView()
            } catch {
                print("Error:", error)
            }
        }
    }
}
