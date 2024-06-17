import SnapKit
import Foundation
import UIKit
import SofaAcademic

class SelectedLeagueViewController: UIViewController {
    
    private let tournamentId: Int
    private var tournament: Tournament?
    
    private var lastMatches: [Event] = []
    private var nextMatches: [Event] = []
    private var eventsGroupedByRound: [[Event]] = []
    
    private let blueContainer = UIView()
    private let leagueHeaderView = TeamTournamentHeaderView()
    private let leagueTabBarView = CustomLeagueTabView()
    private var selectedTab = CustomLeagueTabView.matchesTitle
    
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let containerView = UIView()
    private var currentChild = UIViewController()
    
    
    init(tournamentId: Int) {
        self.tournamentId = tournamentId
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addViews()
        styleViews()
        setupConstraints()
        
        leagueHeaderView.eventDelegate = self
        leagueTabBarView.delegate = self
        
        fetchLeagueData()
        fetchLeagueMatches()
    }
}

//MARK: BaseViewProtocol
extension SelectedLeagueViewController: BaseViewProtocol {
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(leagueHeaderView)
        view.addSubview(leagueTabBarView)
        view.addSubview(containerView)
        setupLoadingIndicator()
        
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
    }
    
    func styleViews() {
        view.backgroundColor = .white
        containerView.backgroundColor = .white
        blueContainer.backgroundColor = .colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        leagueHeaderView.snp.makeConstraints {
            $0.top.equalTo(blueContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        leagueTabBarView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(leagueHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(leagueTabBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: UIGestureRecognizerDelegate
extension SelectedLeagueViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: ReturnButtonDelegate
extension SelectedLeagueViewController: ReturnButtonDelegate {
    
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: TeamTournamentTabSelectDelegate
extension SelectedLeagueViewController: TeamTournamentTabSelectDelegate {
    
    func reactToTeamTournamentTabSelect(tabTitle: String) {
        if (selectedTab != tabTitle) {
            selectedTab = tabTitle
            currentChild.remove()
            switch selectedTab {
            case CustomTeamTabView.matchesTitle:
                fetchLeagueMatches()
            default:
                print("Invalid selection")
            }
        }
    }
}

//MARK: Private methods
private extension SelectedLeagueViewController {
    
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
    
    private func updateView() {
        if tournament != nil {
            switch selectedTab {
            case CustomTeamTabView.matchesTitle:
                currentChild = LeagueMatchesViewController(leagueEvents: eventsGroupedByRound)
                
            case CustomTeamTabView.standingsTitle:
                print("Standings")
                
            default:
                print("Default")
            }
        
            customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
        }
    }
    
    private func fetchLeagueMatches() {
        startLoading()
        Task {
            do {
                let leagueNextMatchesResult = await ApiClient().getTournamentNextMatches(tournamentId: tournamentId)
                switch leagueNextMatchesResult {
                case .success(let matches):
                    self.nextMatches = matches
                case .failure(let error):
                    print("Error fetching next matches data:", error)
                }
                
                let leagueLastMatchesResult = await ApiClient().getTournamentLastMatches(tournamentId: tournamentId)
                switch leagueLastMatchesResult {
                case .success(let matches):
                    self.lastMatches = matches
                case .failure(let error):
                    print("Error fetching last matches data:", error)
                }
                
                eventsGroupedByRound = Helpers.groupMatchesByRound(lastMatches: lastMatches, nextMatches: nextMatches)
                updateView()
            }
            stopLoading()
        }
    }
    
    private func fetchLeagueData() {
        startLoading()
        Task {
            do {
                let leagueDataResult = await ApiClient().getTournamentData(tournamentId: tournamentId)
                switch leagueDataResult {
                case .success(let tournament):
                    self.tournament = tournament
                    leagueHeaderView.updateTournament(tournamentData: tournament)
                case .failure(let error):
                    print("Error fetching league data:", error)
                }
            }
            stopLoading()
        }
    }
}
