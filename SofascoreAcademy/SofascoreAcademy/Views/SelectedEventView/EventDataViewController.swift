import UIKit
import SnapKit
import SofaAcademic

class EventDataViewController: UIViewController {
    
    private let whiteContainer = UIView()
    private let matchData: Event
    private let eventHeader = EventHeader()
    private let eventMatchupView = EventMatchupView()
    
    init(matchData: Event) {
        self.matchData = matchData
        super.init(nibName: nil, bundle: nil)
        
        eventHeader.eventDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView() {
        addViews()
        styleViews()
        setupConstraints()
        
//        fetchEventIncidents(eventId: matchData.id)
        
        eventHeader.update(matchData: matchData)
        eventMatchupView.updateTeamNames(homeTeamName: matchData.homeTeam.name, awayTeamName: matchData.awayTeam.name)
        eventMatchupView.updateScoreView(matchData: matchData)
        
        fetchLeagueLogoFromApi(tournamentId: matchData.tournament.id, section: 0)
        fetchTeamsLogosFromApi(homeTeamId: matchData.homeTeam.id, awayTeamId: matchData.awayTeam.id, indexPath: [0,0])
        
        if(matchData.status == "notstarted") {
            addNotStartedEventView()
        }
    }
}

extension EventDataViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(whiteContainer)
        view.addSubview(eventHeader)
        view.addSubview(eventMatchupView)
    }
    
    func styleViews() {
        view.backgroundColor = Colors.surface0
        whiteContainer.backgroundColor = .white
        eventHeader.backgroundColor = .white
        eventMatchupView.backgroundColor = .white
    }
    
    func setupConstraints() {
        whiteContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        eventHeader.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(whiteContainer.snp.bottom)
            $0.height.equalTo(48)
        }
        
        eventMatchupView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(eventHeader.snp.bottom)
            $0.height.equalTo(112)
        }
    }
}

// MARK: LeagueLogoLoadDelegate
extension EventDataViewController: LeagueLogoLoadDelegate {
    func fetchLeagueLogoFromApi(tournamentId: Int, section: Int) {
        Task {
            do {
                let result =  await ApiClient().getLeagueLogoApi(tournamentId: tournamentId)
                switch result {
                case .success(let leagueLogo):
                    eventHeader.updateLeagueLogo(leagueLogo: leagueLogo)
                case .failure(let error):
                    print("Error fetching league logo: \(error)")
                }
            }
        }
    }
}

// MARK: ReturnButtonDelegate
extension EventDataViewController: ReturnButtonDelegate {
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: TeamLogoLoadProtocol
extension EventDataViewController: TeamLogoLoadProtocol {
    func fetchTeamsLogosFromApi(homeTeamId: Int, awayTeamId: Int, indexPath: IndexPath) {
        Task {
            do {
                let homeTeamLogoResult =  await ApiClient().getTeamLogoApi(teamId: homeTeamId)
                let awayTeamLogoResult =  await ApiClient().getTeamLogoApi(teamId: awayTeamId)
                
                switch homeTeamLogoResult {
                case .success(let homeTeamLogo):
                    switch awayTeamLogoResult {
                    case .success(let awayTeamLogo):
                        eventMatchupView.updateHomeTeamLogo(teamLogo: homeTeamLogo)
                        eventMatchupView.updateAwayTeamLogo(teamLogo: awayTeamLogo)
                    case .failure(let error):
                        print("Error fetching away team logo: \(error)")
                    }
                case .failure(let error):
                    print("Error fetching home team logo: \(error)")
                }
            }
        }
    }
}

extension EventDataViewController {
    
    func fetchEventIncidents(eventId: Int) {
        Task {
            do {
                let requestFootballEventIncidentsResult =  await ApiClient().getFootballIncidents(eventId: eventId)
                
                switch requestFootballEventIncidentsResult {
                case .success(let requestDataFootball):
                    print(requestDataFootball)
                case .failure(let error):
                    print("Error fetching football data:", error)
                }
                
            }
        }
    }
    
    func addNotStartedEventView() {
        let notStartedEventView = NotStartedEventView()
        view.addSubview(notStartedEventView)
        
        notStartedEventView.snp.makeConstraints {
            $0.top.equalTo(eventMatchupView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
    }
}

