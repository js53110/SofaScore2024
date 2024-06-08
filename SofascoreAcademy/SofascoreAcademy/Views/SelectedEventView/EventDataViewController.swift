import UIKit
import SnapKit
import SofaAcademic

class EventDataViewController: UIViewController {
    
    private let tableView = UITableView()
    private var eventData: [FootballIncident] = []
    private let whiteContainer = UIView()
    private let matchData: Event
    private let eventHeader = EventHeader()
    private let eventMatchupView = EventMatchupView()
        
    init(matchData: Event) {
        self.matchData = matchData
        super.init(nibName: nil, bundle: nil)
        
        eventHeader.eventDelegate = self
        eventMatchupView.teamTapDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        setupView()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView() {
        
        addViews()
        styleViews()
        setupConstraints()
        
        
        eventHeader.update(matchData: matchData)
        eventMatchupView.updateTeamNames(homeTeam: matchData.homeTeam, awayTeam: matchData.awayTeam)
        eventMatchupView.updateScoreView(matchData: matchData)
        
        eventHeader.updateLeagueLogo(tournamentId: matchData.tournament.id)
        eventMatchupView.updateHomeTeamLogo(teamId: matchData.homeTeam.id)
        eventMatchupView.updateAwayTeamLogo(teamId: matchData.awayTeam.id)
        
        if(matchData.status == "notstarted") {
            addNotStartedEventView()
        }
        else if(matchData.status == "finished") {
            fetchEventIncidents(eventId: matchData.id)
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
        view.backgroundColor = .surfaceSurface0
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

// MARK: ReturnButtonDelegate
extension EventDataViewController: ReturnButtonDelegate {
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension EventDataViewController: TeamTapDelegate {
    func reactToTeamTap(teamId: Int) {
        let teamViewController = TeamViewController(teamId: teamId)
        navigationController?.pushViewController(teamViewController, animated: true)
    }
}

// MARK: Additional methods
extension EventDataViewController {
    
    func fetchEventIncidents(eventId: Int) {
        Task {
            do {
                let requestFootballEventIncidentsResult =  await ApiClient().getFootballIncidents(eventId: eventId)
                
                switch requestFootballEventIncidentsResult {
                case .success(let requestDataFootball):
                    eventData = requestDataFootball.reversed()
                    setupTableView()
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
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(eventMatchupView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        
        tableView.register(
            IncidentViewCell.self,
            forCellReuseIdentifier: IncidentViewCell.identifier
        )
        
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
    }
}

// MARK: UITableViewDataSource
extension EventDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: IncidentViewCell.identifier,
            for: indexPath) as? IncidentViewCell {
            let dataForRow = eventData[indexPath.row]
            cell.setupCell(data: dataForRow, matchData: matchData)
            return cell
        } else {
            fatalError("Failed to equeue cell")
        }
    }
}

// MARK: UITableViewDelegate
extension EventDataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let incident = eventData[indexPath.row]
        if(incident.type == "period") {
            return 40
        }
        return 56
    }
}

extension EventDataViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


