import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsViewController: UIViewController {
    
    private let teamDetails: Team
    private let teamTournaments: [Tournament]
    private let teamMatches: [LeagueData]
    private let nextEvent: [Event]
    private let teamPlayers: [Player]
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let divider = CustomDivider()
    
    private let teamInfoHeadline = TeamHeadlineView(title: "Team Info")
    private let teamCoachDetailsView = TeamCoachDetailsView()
    private let teamPlayersDetailView = TeamPlayersDetailsView()
    
    private let tournamentsInfoHeadline = TeamHeadlineView(title: "Tournaments")
    private let tournamentCollectionView: UICollectionView
    
    private let venueHeadline = TeamHeadlineView(title: "Venue")
    private let venueDetailsView = VenueDetailsView()
    
    private let nextMatchHeadline = TeamHeadlineView(title: "Next match")
    
    private let nextMatchTableView = UITableView()
    
    private var collectionViewHeightConstraint: Constraint?
    weak var matchTapDelegate: MatchTapDelegate?
    
    init(teamDetails: Team, teamTournaments: [Tournament], teamMatches: [LeagueData], nextEvent: [Event], teamPlayers: [Player]) {
        self.teamDetails = teamDetails
        self.teamTournaments = teamTournaments
        self.teamMatches = teamMatches
        self.nextEvent = nextEvent
        self.teamPlayers = teamPlayers
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.tournamentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
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
    
    private func setupView() {
        addViews()
        styleViews()
        setupConstraints()
        
        setupCollectionView()
        setupTableView()
        
        teamCoachDetailsView.update(coachName: teamDetails.managerName ?? "Unknown", country: teamDetails.country)
        teamPlayersDetailView.update(teamPlayers: teamPlayers, country: teamDetails.country)
        venueDetailsView.update(venueDesc: "Stadium", venueName: teamDetails.venue ?? "Unknown")
    }
    
    private func setupCollectionView() {
        tournamentCollectionView.dataSource = self
        tournamentCollectionView.delegate = self
        tournamentCollectionView.register(TournamentCardViewCell.self, forCellWithReuseIdentifier: TournamentCardViewCell.identifier)
        tournamentCollectionView.isScrollEnabled = false
        tournamentCollectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    deinit {
        tournamentCollectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newSize = change?[.newKey] as? CGSize {
                collectionViewHeightConstraint?.update(offset: newSize.height)
                view.layoutIfNeeded()
            }
        }
    }
}

extension TeamDetailsViewController: BaseViewProtocol {
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(teamInfoHeadline)
        contentView.addSubview(teamCoachDetailsView)
        contentView.addSubview(teamPlayersDetailView)
        contentView.addSubview(tournamentsInfoHeadline)
        contentView.addSubview(tournamentCollectionView)
        contentView.addSubview(divider)
        contentView.addSubview(venueHeadline)
        contentView.addSubview(venueDetailsView)
        contentView.addSubview(nextMatchHeadline)
        contentView.addSubview(nextMatchTableView)
    }
    
    func styleViews() {
        tournamentCollectionView.backgroundColor = .clear
        nextMatchTableView.backgroundColor = .white
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        teamInfoHeadline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        teamCoachDetailsView.snp.makeConstraints {
            $0.top.equalTo(teamInfoHeadline.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        teamPlayersDetailView.snp.makeConstraints {
            $0.top.equalTo(teamCoachDetailsView.snp.bottom).offset(7)
            $0.height.equalTo(116)
            $0.leading.trailing.equalToSuperview()
        }
        
        tournamentsInfoHeadline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(teamPlayersDetailView.snp.bottom).offset(16)
        }
        
        tournamentCollectionView.snp.makeConstraints {
            $0.top.equalTo(tournamentsInfoHeadline.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            collectionViewHeightConstraint = $0.height.equalTo(0).constraint
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(tournamentCollectionView.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        venueHeadline.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        venueDetailsView.snp.makeConstraints {
            $0.top.equalTo(venueHeadline.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        nextMatchHeadline.snp.makeConstraints {
            $0.top.equalTo(venueDetailsView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        nextMatchTableView.snp.makeConstraints() {
            $0.top.equalTo(nextMatchHeadline.snp.bottom)
            $0.height.equalTo(112)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension TeamDetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension TeamDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamTournaments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TournamentCardViewCell.identifier, for: indexPath) as? TournamentCardViewCell {
            let tournament = teamTournaments[indexPath.item]
            cell.setupCell(tournament: tournament)
            return cell
        } else {
            fatalError("Failed to dequeue cell")
        }
    }
}

extension TeamDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 96)
    }
}

private extension TeamDetailsViewController {
    
    func setupTableView() {
        nextMatchTableView.register(
            MatchViewCell.self,
            forCellReuseIdentifier: MatchViewCell.identifier
        )
        
        nextMatchTableView.register(
            LeagueInfoViewHeader.self,
            forHeaderFooterViewReuseIdentifier: LeagueInfoViewHeader.identifier
        )
        
        nextMatchTableView.separatorStyle = .none
        nextMatchTableView.reloadData()
        
        //MARK: Assigning delegates
        nextMatchTableView.dataSource = self
        nextMatchTableView.delegate = self
        
        if #available(iOS 15.0, *) {
            nextMatchTableView.sectionHeaderTopPadding = 0
        }
    }
}

// MARK: UITableViewDataSource
extension TeamDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.identifier,
            for: indexPath) as? MatchViewCell {
            let dataForRow = nextEvent.first
            cell.update(data: dataForRow!)
            return cell
        } else {
            fatalError("Failed to equeue cell")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueInfoViewHeader.identifier) as? LeagueInfoViewHeader {
            let sectionData = nextEvent.first!.tournament
            
            headerView.update(
                countryName: sectionData.country.name,
                leagueName: sectionData.name,
                tournamentId: sectionData.id
            )
            
            return headerView
        } else {
            fatalError("Failed to dequeue header")
        }
    }
}

// MARK: UITableViewDelegate
extension TeamDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMatch: Event = nextEvent.first!
        navigationController?.pushViewController(EventDataViewController(matchData: selectedMatch), animated: true)
    }
}

