import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MainViewController: UIViewController {
    
    private let appHeader = AppHeader()
    private let datePickerView = DatePickerCollectionView()
    private let datesMatchesDivider = DatesMatchesDividerView()
    private let customTabBar: CustomTabView
    private let blueContainer = UIView()
    private let containerView = UIView()
    private var currentChild: SportViewController
    private let savedSportSlug = UserDefaultsService.retrieveDataFromUserDefaults()
    private var currentSportSlug: SportSlug
    
    init() {
        self.currentChild = SportViewController(sportSlug: savedSportSlug)
        self.customTabBar = CustomTabView(sportSlug: savedSportSlug)
        self.currentSportSlug = savedSportSlug
        super.init(nibName: nil, bundle: nil)
        
        displayEventsForSelectedDate(selectedDate: "2024-04-28")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        customTabBar.delegate = self
        appHeader.delegate = self
        currentChild.delegate = self
        datePickerView.datePickDelegate = self
    }
}

// MARK: BaseViewProtocol
extension MainViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(appHeader)
        view.addSubview(customTabBar)
        view.addSubview(datePickerView)
        view.addSubview(datesMatchesDivider)
        view.addSubview(containerView)
        
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
    }
    
    func styleViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        blueContainer.backgroundColor = Colors.colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        appHeader.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        customTabBar.snp.makeConstraints() {
            $0.top.equalTo(appHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        datePickerView.snp.makeConstraints(){
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        datesMatchesDivider.snp.makeConstraints() {
            $0.top.equalTo(datePickerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints() {
            $0.top.equalTo(datesMatchesDivider.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: ParentSportSlugPickerProtocol
extension MainViewController: ParentSportSlugPicker {
    
    func displaySelectedSport(selectedSportSlug: SportSlug?) {
        if(selectedSportSlug != currentSportSlug) {
            currentChild.remove()
            
            if let selectedSportSlug = selectedSportSlug {
                UserDefaultsService.saveDataToUserDefaults(sportSlug: selectedSportSlug)
                currentChild = SportViewController(sportSlug: selectedSportSlug)
                currentSportSlug = selectedSportSlug
                currentChild.delegate = self
                customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
            }
        }
    }
}

// MARK: AppHeaderDelegate
extension MainViewController: AppHeaderDelegate {
    
    func reactToSetingsTap() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        settingsViewController.title = "Settings"
        present(settingsViewController, animated: true)
    }
}

// MARK: MatchTapDelegate
extension MainViewController: MatchTapDelegate {
    
    func displayMatchInfoOnTap(selectedMatch: Event) {
        navigationController?.pushViewController(MatchDataViewController(matchData: selectedMatch), animated: true)
    }
}

extension MainViewController: DatePickDelegate {
    
    func displayEventsForSelectedDate(selectedDate: String)  {
        print("Selected", selectedDate)
        Task {
            do {
                let requestDataFootball = try await ApiClient().getEventDataNew(sportSlug: .football, date: selectedDate)
                let requestDataBasketball = try await ApiClient().getEventDataNew(sportSlug: .basketball, date: selectedDate)
                let requestDataAmFootball = try await ApiClient().getEventDataNew(sportSlug: .americanFootball, date: selectedDate)

                let dataFootball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataFootball)
                let dataBasketball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataBasketball)
                let dataAmFootball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataAmFootball)

                leaguesData1 = dataFootball
                leaguesData2 = dataBasketball
                leaguesData3 = dataAmFootball
            } catch {
                print("Error:", error)
            }
        }
        
    }
}
