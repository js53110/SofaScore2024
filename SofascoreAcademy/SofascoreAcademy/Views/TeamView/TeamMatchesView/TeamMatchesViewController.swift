import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamMatchesViewController: UIViewController {
    
    private let tableView = UITableView()
    private var data: Array<LeagueData>
    private let noDataLabel = UILabel()
    
    weak var matchTapDelegate: MatchTapDelegate?
    weak var dayInfoDelegate: DayInfoProtocol?
    
    init(data: [LeagueData]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        addViews()
        styleViews()
        setupConstraints()
        setupDayInfo()
        setupTableView()
    }
}

// MARK: UITableViewDataSource
extension TeamMatchesViewController: UITableViewDataSource {
    
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
                tournamentId: sectionData.id
            )
            
            return headerView
        } else {
            fatalError("Failed to dequeue header")
        }
    }
}

// MARK: UITableViewDelegate
extension TeamMatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMatch: Event = data[indexPath.section].events[indexPath.row]
        navigationController?.pushViewController(EventDataViewController(matchData: selectedMatch), animated: true)
//        matchTapDelegate?.displayMatchInfoOnTap(selectedMatch: selectedMatch)
    }
}

// MARK: BaseViewProtocol
extension TeamMatchesViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Private methods
private extension TeamMatchesViewController {
    
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
        
        noDataLabel.font = .action
        noDataLabel.textColor = .onSurfaceOnSurfaceLv2
    }
}

extension TeamMatchesViewController {
    
    func checkNoData() {
        if(data.count == 0) {
            setupNoDataView()
        }
    }
}

extension TeamMatchesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

