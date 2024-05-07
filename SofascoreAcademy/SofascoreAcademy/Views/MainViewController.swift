import Foundation
import UIKit
import SofaAcademic
import SnapKit

var selectedDate: String = Helpers.getTodaysDate()
var firstStart: Bool = true

class MainViewController: UIViewController {
    
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let refreshControl = UIRefreshControl()
    private let scrollView = CustomScrollView()
    private let contentView = UIView()
    private let appHeader = AppHeader()
    private let datePickerView = DatePickerCollectionView()
    private let datesMatchesDivider = DatesMatchesDividerView()
    private var customTabBar: CustomTabView
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupRefreshControl()
        setupView()
        displayEventsForSelectedDate(selectedDate: selectedDate)
    }
    
    func setupView() {
        addViews()
        styleViews()
        setupConstraints()
        
        customTabBar.delegate = self
        appHeader.delegate = self
        currentChild.matchTapDelegate = self
        datePickerView.datePickDelegate = self
        currentChild.dayInfoDelegate = self
    }
}

// MARK: BaseViewProtocol
extension MainViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appHeader)
        contentView.addSubview(customTabBar)
        contentView.addSubview(datePickerView)
        contentView.addSubview(datesMatchesDivider)
        contentView.addSubview(containerView)
        
        setupLoadingIndicator()
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
        
    }
    
    func styleViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        blueContainer.backgroundColor = Colors.colorPrimaryDefault
    }
    
    func updateView() {
        currentChild.remove()
        currentChild = SportViewController(sportSlug: currentSportSlug)
        currentChild.matchTapDelegate = self
        currentChild.dayInfoDelegate = self
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(appHeader.snp.bottom)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide)
            $0.width.equalToSuperview()
        }
        
        appHeader.snp.makeConstraints() {
            $0.top.equalTo(contentView.snp.top)
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
                currentChild.matchTapDelegate = self
                currentChild.dayInfoDelegate = self
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

//MARK: DatePickDelegate
extension MainViewController: DatePickDelegate {
    
    func displayEventsForSelectedDate(selectedDate: String)  {
        currentChild.remove()
        startLoading()
        
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
                
                updateView()
            } catch {
                print("Error:", error)
            }
            
            stopLoading()
        }
    }
}

//MARK: DayInfoProtocol
extension MainViewController: DayInfoProtocol {
    
    func displayInfoForDate(count: Int) {
        datesMatchesDivider.updateInfo(count: count, date: Helpers.getDateAndDayFromString(dateString: selectedDate))
    }
}

// MARK: Private Methods
private extension MainViewController {
    
    func setupLoadingIndicator() {
        containerView.addSubview(loadingIndicator)

        loadingIndicator.color = .gray
        loadingIndicator.hidesWhenStopped = true
                
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func setupScrollView() {
        scrollView.refreshControl = refreshControl
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        let workItem = DispatchWorkItem {
            DispatchQueue.main.async {
                self.displayEventsForSelectedDate(selectedDate: selectedDate)
                self.refreshControl.endRefreshing()
                self.refreshControl.isEnabled = true
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
}
