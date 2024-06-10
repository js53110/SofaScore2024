import UIKit
import SnapKit
import Foundation
import SofaAcademic

class LeaguesViewController: UIViewController {
    
    private var leaguesData: [Tournament] = []
    private let blueContainer = UIView()
    private let leaguesHeader = LeaguesHeaderView()
    private var customTabBar: CustomTabView
    private let containerView = UIView()
    private var currentChild: SportLeaguesViewController
    private let savedSportSlug = UserDefaultsService.retrieveDataFromUserDefaults()
    private var currentSportSlug: SportSlug
    
    init() {
        self.customTabBar = CustomTabView(sportSlug: savedSportSlug)
        self.currentSportSlug = savedSportSlug
        self.currentChild = SportLeaguesViewController(tournaments: [])
        super.init(nibName: nil, bundle: nil)
        
        loadLeaguesData(selectedSport: currentSportSlug)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        leaguesHeader.eventDelegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        customTabBar.delegate = self
        
        addChild(currentChild)
        containerView.addSubview(currentChild.view)
        currentChild.didMove(toParent: self)
    }
    
    func updateView() {
        currentChild.remove()
        currentChild = SportLeaguesViewController(tournaments: leaguesData)
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
    }
}

extension LeaguesViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(leaguesHeader)
        view.addSubview(customTabBar)
        view.addSubview(containerView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        blueContainer.backgroundColor = .colorPrimaryDefault
        leaguesHeader.backgroundColor = .colorPrimaryDefault
        customTabBar.backgroundColor = .colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        leaguesHeader.snp.makeConstraints {
            $0.top.equalTo(blueContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        customTabBar.snp.makeConstraints {
            $0.top.equalTo(leaguesHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: ParentSportSlugPickerDelegate
extension LeaguesViewController: ParentSportSlugPicker {
    
    func displaySelectedSport(selectedSportSlug: SportSlug?) {
        if selectedSportSlug != currentSportSlug {
            currentChild.remove()
            
            if let selectedSportSlug = selectedSportSlug {
                currentSportSlug = selectedSportSlug
                loadLeaguesData(selectedSport: currentSportSlug)
            }
        }
    }
}

// MARK: ReturnButtonDelegate
extension LeaguesViewController: ReturnButtonDelegate {
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UIGestureRecognizerDelegate
extension LeaguesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: Data loading methods
extension LeaguesViewController {
    
    func loadLeaguesData(selectedSport: SportSlug) {
        leaguesData = []
        currentChild.remove()
        
        Task {
            do {
                switch selectedSport {
                case .football:
                    let requestFootballLeaguesData = await ApiClient().getLeaguesData(sportSlug: .football)
                    switch requestFootballLeaguesData {
                    case .success(let footballLeaguesData):
                        leaguesData = footballLeaguesData
                    case .failure(let error):
                        print("Error fetching football data:", error)
                    }
                case .basketball:
                    let requestBasketballLeaguesData = await ApiClient().getLeaguesData(sportSlug: .basketball)
                    switch requestBasketballLeaguesData {
                    case .success(let basketbalLeaguesData):
                        leaguesData = basketbalLeaguesData
                    case .failure(let error):
                        print("Error fetching basketball data:", error)
                    }
                case .americanFootball:
                    let requestAmFootballData = await ApiClient().getLeaguesData(sportSlug: .americanFootball)
                    switch requestAmFootballData {
                    case .success(let amFootballLeaguesData):
                        leaguesData = amFootballLeaguesData
                    case .failure(let error):
                        print("Error fetching American football data:", error)
                    }
                }
                updateView()
            }
        }
    }
}
