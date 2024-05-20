import Foundation
import UIKit
import SofaAcademic
import SnapKit

var firstStart: Bool = true

class MainViewController: UIViewController {
    
    private var selectedDate: String = Helpers.getTodaysDate()
    
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let refreshControl = UIRefreshControl()
    private let scrollView = MainScrollView()
    private let contentView = UIView()
    private let appHeader = AppHeader()
    private let datePickerView = DatePickerCollectionView(selectedDate: Helpers.getTodaysDate())
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
        
        //MARK: Assigning delegates
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
        currentChild.checkNoData()
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
    
    func displayEventsForSelectedDate(selectedDate: String) {
        self.selectedDate = selectedDate
        currentChild.remove()
        startLoading()
        
        reloadData(selectedDate: selectedDate, selectedSport: currentSportSlug)
    }
    
}

// MARK: ParentSportSlugPickerProtocol
extension MainViewController: ParentSportSlugPicker {
    
    func displaySelectedSport(selectedSportSlug: SportSlug?) {
        if(selectedSportSlug != currentSportSlug) {
            currentChild.remove()
            if let selectedSportSlug = selectedSportSlug {
                startLoading()
                currentSportSlug = selectedSportSlug
                reloadData(selectedDate: selectedDate, selectedSport: currentSportSlug)
            }
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
                self.displayEventsForSelectedDate(selectedDate: self.selectedDate)
                self.refreshControl.endRefreshing()
                self.refreshControl.isEnabled = true
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    func reloadData(selectedDate: String, selectedSport: SportSlug) {
        print("call")
        Task {
            do {
                switch selectedSport {
                case .football:
                    let requestDataFootballResult =  await ApiClient().getData(sportSlug: .football, date: selectedDate)
                    switch requestDataFootballResult {
                    case .success(let requestDataFootball):
                        let dataFootball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataFootball)
                        footballData = dataFootball
                    case .failure(let error):
                        print("Error fetching football data:", error)
                    }
                case .basketball:
                    let requestDataBasketballResult =  await ApiClient().getData(sportSlug: .basketball, date: selectedDate)
                    switch requestDataBasketballResult {
                    case .success(let requestDataBasketball):
                        let dataBasketball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataBasketball)
                        basketballData = dataBasketball
                    case .failure(let error):
                        print("Error fetching basketball data:", error)
                    }
                case .americanFootball:
                    let requestDataAmFootballResult =  await ApiClient().getData(sportSlug: .americanFootball, date: selectedDate)
                    switch requestDataAmFootballResult {
                    case .success(let requestDataAmFootball):
                        let dataAmFootball: [LeagueData] = Helpers.groupEventsByTournament(eventsData: requestDataAmFootball)
                        americanFootballData = dataAmFootball
                    case .failure(let error):
                        print("Error fetching American football data:", error)
                    }
                }
                updateView()
            }
            
            stopLoading()
        }
    }
}
