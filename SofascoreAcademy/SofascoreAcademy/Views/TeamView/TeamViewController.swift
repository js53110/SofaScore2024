import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TeamViewController: UIViewController {
    
    private let blueContainer = UIView()
    private let teamId: Int
    private var teamDetails: Team?
    private var teamMatches: [LeagueData] = []
    private var nextMatch: [Event] = []
    private var teamPlayers: [Player] = []
    private var teamTournaments: [Tournament] = []
    
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    private let teamHeaderView: TeamTournamentHeaderView = TeamTournamentHeaderView()
    private let teamTabBarView = CustomTeamTabView()
    private let containerView = UIView()
    private var currentChild = UIViewController()
    private var selectedTab = CustomTeamTabView.detailsTitle
    
    init(teamId: Int) {
        self.teamId = teamId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupView() {
        addViews()
        styleViews()
        setupConstraints()
        
        fetchTeamDetails()
        
        teamHeaderView.eventDelegate = self
        teamTabBarView.delegate = self
    }
    
    private func updateView() {
        if let teamDetails = teamDetails {
            teamHeaderView.updateTeam(teamData: teamDetails)
            
            switch selectedTab {
            case CustomTeamTabView.detailsTitle:
                currentChild = TeamDetailsViewController(teamDetails: teamDetails, teamTournaments: teamTournaments, teamMatches: teamMatches, nextEvent: nextMatch, teamPlayers: teamPlayers)
                
            case CustomTeamTabView.matchesTitle:
                currentChild = TeamMatchesViewController(data: teamMatches)
                
            case CustomTeamTabView.standingsTitle:
                print("Standings")
                
            case CustomTeamTabView.squadTitle:
                print("Squad")
                
            default:
                print("Default")
            }
            customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
        }
    }
}

//MARK: BaseViewProtocol
extension TeamViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(teamHeaderView)
        view.addSubview(teamTabBarView)
        view.addSubview(containerView)
        setupLoadingIndicator()
        
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
    }
    
    func styleViews() {
        blueContainer.backgroundColor = .colorPrimaryDefault
        teamTabBarView.backgroundColor = .colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        teamHeaderView.snp.makeConstraints {
            $0.top.equalTo(blueContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        teamTabBarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(teamHeaderView.snp.bottom)
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(teamTabBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: ReturnButtonDelegate
extension TeamViewController: ReturnButtonDelegate {
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: TeamTournamentTabSelectDelegate
extension TeamViewController: TeamTournamentTabSelectDelegate {
    func reactToTeamTournamentTabSelect(tabTitle: String) {
        if (selectedTab != tabTitle) {
            selectedTab = tabTitle
            currentChild.remove()
            switch selectedTab {
            case CustomTeamTabView.matchesTitle:
                fetchTeamMatches()
            case CustomTeamTabView.detailsTitle:
                fetchTeamDetails()
            default:
                print("Invalid selection")
            }
        }
    }
}

//MARK: TeamViewController
private extension TeamViewController {
    
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
}

//MARK: UIGestureRecognizerDelegate
extension TeamViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: Data loading methods
private extension TeamViewController {
    
    func fetchTeamDetails() {
        startLoading()
        Task {
            do {
                let teamDetailsResult = await ApiClient().getTeamData(teamId: teamId)
                switch teamDetailsResult {
                case .success(let team):
                    self.teamDetails = team
                case .failure(let error):
                    print("Error fetching teamDetails data:", error)
                }
                
                let teamPlayersResult = await ApiClient().getTeamPlayers(teamId: teamId)
                switch teamPlayersResult {
                case .success(let teamPlayers):
                    self.teamPlayers = teamPlayers
                case .failure(let error):
                    print("Error fetching teamPlayers data:", error)
                }
                
                let teamTournamentsResult = await ApiClient().getTeamTournaments(teamId: teamId)
                switch teamTournamentsResult {
                case .success(let teamTournaments):
                    self.teamTournaments = teamTournaments
                case .failure(let error):
                    print("Error fetching teamTournaments data:", error)
                }
                
                let nextMatchResult = await ApiClient().getTeamNextMatches(teamId: teamId)
                switch nextMatchResult {
                case .success(let nextMatch):
                    self.nextMatch = nextMatch
                case .failure(let error):
                    print("Error fetching nextMatch data:", error)
                }
                updateView()
            }
            stopLoading()
        }
    }
    
    func fetchTeamMatches() {
        startLoading()
        Task {
            do {
                let teamMatchesResult = await ApiClient().getTeamLastMatches(teamId: teamId)
                switch teamMatchesResult {
                case .success(let matches):
                    self.teamMatches = Helpers.groupEventsByTournament(eventsData: matches)
                case .failure(let error):
                    print("Error fetching teamDetails data:", error)
                }
                updateView()
            }
            stopLoading()
        }
    }
}
