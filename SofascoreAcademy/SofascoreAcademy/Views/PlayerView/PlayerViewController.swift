import Foundation
import UIKit
import SnapKit
import SofaAcademic

class PlayerViewController: UIViewController {
    
    private var player: Player?
    private let playerId: Int
    
    private var events: [LeagueData] = []
    private var lastEvents: [Event] = []

    
    private let blueContainer = UIView()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let containerView = UIView()
    private let playerHeaderView: PlayerHeaderView = PlayerHeaderView()
    private let playerTeamView = PlayerTeamView()
    private let playerDetailsView = PlayerDetailsView()
    private let playerMatchesDividerView = PlayerMatchesDividerView()
    private let tableView = UITableView()
    
    init(playerId: Int) {
        self.playerId = playerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupLoadingIndicator()
        setupView()
        fetchPlayerDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupView() {
        addViews()
        styleViews()
        setupConstraints()
    }
    
    private func updateView() {
        guard let player = player else { return }
        playerHeaderView.update(player: player)
        playerTeamView.update(team: player.country)
        playerDetailsView.update(player: player)
        fetchPlayerMatches(playerId: playerId)
        playerHeaderView.eventDelegate = self
    }
}

//MARK: UIGestureRecognizerDelegate
extension PlayerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: BaseViewProtocol
extension PlayerViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(playerHeaderView)
        view.addSubview(playerTeamView)
        view.addSubview(playerDetailsView)
        view.addSubview(playerMatchesDividerView)
        view.addSubview(containerView)
    }
    
    func styleViews() {
        blueContainer.backgroundColor = .colorPrimaryDefault
        tableView.backgroundColor = .white
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        playerHeaderView.snp.makeConstraints {
            $0.top.equalTo(blueContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        playerTeamView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(playerHeaderView.snp.bottom)
        }
        
        playerDetailsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(playerTeamView.snp.bottom)
        }
        
        playerMatchesDividerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(playerDetailsView.snp.bottom).offset(8)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(playerMatchesDividerView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

//MARK: Data loading methods
extension PlayerViewController {
    
    func fetchPlayerDetails() {
        startLoading()
        Task {
            do {
                let playerResult = await ApiClient().getPlayerDetails(playerId: playerId)
                switch playerResult {
                case .success(let player):
                    self.player = player
                case .failure(let error):
                    print("Error fetching player data:", error)
                }
                updateView()
            }
        }
    }
    
    func fetchPlayerMatches(playerId: Int) {
        events = []
        
        Task {
            do {
                let requestPlayerLastEventsData =  await ApiClient().getPlayerLastMatches(playerId: playerId)
                switch requestPlayerLastEventsData {
                case .success(let playerEvents):
                    lastEvents = playerEvents
                case .failure(let error):
                    print("Error fetching football data:", error)
                }
                
                let eventsByTournament: [LeagueData] = Helpers.groupEventsByTournament(eventsData: lastEvents)
                events = eventsByTournament
                setupTableView()
            }
            stopLoading()
        }
    }
}

//MARK: PlayerViewController
private extension PlayerViewController {
    
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

//MARK: ReturnButtonDelegate
extension PlayerViewController: ReturnButtonDelegate {
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UITableViewDataSource
extension PlayerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.identifier,
            for: indexPath) as? MatchViewCell else {
            fatalError("Failed to dequeue cell")
        }
        
        cell.prepareForReuse()
        
        let dataForRow = events[indexPath.section].events[indexPath.row]
        if(dataForRow.status == "finished") {
            cell.update(data: dataForRow, displayDate: false)
        } else {
            cell.update(data: dataForRow, displayDate: true)
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueInfoViewHeader.identifier) as? LeagueInfoViewHeader {
            let sectionData = events[section]
            
            headerView.update(
                countryName: sectionData.country,
                leagueName: sectionData.name,
                tournamentId: sectionData.id
            )
            
            headerView.delegate = self
            
            return headerView
        } else {
            fatalError("Failed to dequeue header")
        }
    }
}

//MARK: UITableViewDelegate
extension PlayerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMatch: Event = events[indexPath.section].events[indexPath.row]
        navigationController?.pushViewController(EventDataViewController(matchData: selectedMatch), animated: true)
    }
}

//MARK: Private methods
private extension PlayerViewController {
    
    func setupTableView() {
        tableView.register(
            MatchViewCell.self,
            forCellReuseIdentifier: MatchViewCell.identifier
        )
        
        tableView.register(
            LeagueInfoViewHeader.self,
            forHeaderFooterViewReuseIdentifier: LeagueInfoViewHeader.identifier
        )
        
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        //MARK: Assigning delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: LeagueHeaderTapDelegate
extension PlayerViewController: LeagueTapDelegate {
    func reactToLeagueHeaderTap(tournamentId: Int) {
        navigationController?.pushViewController(SelectedLeagueViewController(tournamentId: tournamentId), animated: true)
    }
}

