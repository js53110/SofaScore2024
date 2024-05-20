import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SportViewController: UIViewController {
    
    private let tableView = UITableView()
    private var data: Array<LeagueData>
    private let noDataLabel = UILabel()
    
    weak var matchTapDelegate: MatchTapDelegate?
    weak var dayInfoDelegate: DayInfoProtocol?
    
    init(sportSlug: SportSlug) {
        self.data = Helpers.determineDataForDisplay(sportSlug: sportSlug)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupDayInfo()
        setupTableView()
        
        
    }
}

// MARK: UITableViewDataSource
extension SportViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.identifier,
            for: indexPath) as? MatchViewCell {
            let dataForRow = data[indexPath.section].events[indexPath.row]
            cell.update(data: dataForRow)
//            fetchTeamsLogosFromApi(homeTeamId: dataForRow.homeTeam.id, awayTeamId: dataForRow.awayTeam.id, indexPath: indexPath)
            return cell
        } else {
            fatalError("Failed to equeue cell")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueInfoViewHeader.identifier) as? LeagueInfoViewHeader {
            let sectionData = data[section]
            
            headerView.update(
                countryName: sectionData.country,
                leagueName: sectionData.name,
                tournamentId: sectionData.id,
                leagueLogo: UIImage()
            )
            
//            fetchLeagueLogoFromApi(tournamentId: sectionData.id, section: section)
            return headerView
        } else {
            fatalError("Failed to dequeue header")
        }
    }
    
}

// MARK: UITableViewDelegate
extension SportViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMatch: Event = data[indexPath.section].events[indexPath.row]
        matchTapDelegate?.displayMatchInfoOnTap(selectedMatch: selectedMatch)
    }
}

// MARK: LeagueLogoLoadDelegate
//extension SportViewController: LeagueLogoLoadDelegate {
//    func fetchLeagueLogoFromApi(tournamentId: Int, section: Int) {
//        Task {
//            do {
//                let result =  await ApiClient().getLeagueLogoApi(tournamentId: tournamentId)
//                switch result {
//                case .success(let leagueLogo):
//                    if let headerView = self.tableView.headerView(forSection: section) as? LeagueInfoViewHeader {
//                        headerView.updateLeagueLogo(leagueLogo: leagueLogo )
//                    }
//                case .failure(let error):
//                    print("Error fetching league logo: \(error)")
//                }
//            }
//        }
//    }
//}

//// MARK: TeamLogoLoadProtocol
//extension SportViewController: TeamLogoLoadProtocol {
//    func fetchTeamsLogosFromApi(homeTeamId: Int, awayTeamId: Int, indexPath: IndexPath) {
//        Task {
//            do {
//                let homeTeamLogoResult =  await ApiClient().getTeamLogoApi(teamId: homeTeamId)
//                let awayTeamLogoResult =  await ApiClient().getTeamLogoApi(teamId: awayTeamId)
//                
//                switch homeTeamLogoResult {
//                case .success(let homeTeamLogo):
//                    switch awayTeamLogoResult {
//                    case .success(let awayTeamLogo):
//                        if let cell = self.tableView.cellForRow(at: indexPath) as? MatchViewCell {
//                            cell.updateHomeTeamLogo(teamLogo: homeTeamLogo )
//                            cell.updateAwayTeamLogo(teamLogo: awayTeamLogo )
//                        }
//                    case .failure(let error):
//                        print("Error fetching away team logo: \(error)")
//                    }
//                case .failure(let error):
//                    print("Error fetching home team logo: \(error)")
//                }
//            }
//        }
//    }
//}


// MARK: BaseViewProtocol
extension SportViewController: BaseViewProtocol{
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Private methods
private extension SportViewController {
    
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
    }
    
    func setupDayInfo() {
        let count = Helpers.getEventsCount(data: data)
        dayInfoDelegate?.displayInfoForDate(count: count)
    }
    
    func setupNoDataView() {
        view.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
        noDataLabel.text = "No events found for selected date"
        
        noDataLabel.font = Fonts.RobotoBold
        noDataLabel.textColor = Colors.surfaceLv2
    }
}

extension SportViewController {
    
    func checkNoData() {
        if(data.count == 0) {
            setupNoDataView()
        }
    }
    
    func updateData() {
        print("a")
    }
}

