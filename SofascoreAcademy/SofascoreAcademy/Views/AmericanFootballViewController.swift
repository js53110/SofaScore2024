import UIKit
import SnapKit
import SofaAcademic

class AmericanFootballViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var delegate: tableCellTap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupTableView()
    }
}

extension AmericanFootballViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        leaguesData3.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesData3[section].matches.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.identifier,
            for: indexPath) as? MatchViewCell {
            let dataForRow = leaguesData3[indexPath.section].matches[indexPath.row]
            cell.update(data: dataForRow)
            return cell
        } else {
            fatalError("Failed to equeue cell")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueInfoViewHeader.identifier) as? LeagueInfoViewHeader {
            let sectionData = leaguesData3[section]
            headerView.update(
                countryName: sectionData.countryName,
                leagueName: sectionData.leagueName,
                leagueLogo: sectionData.leagueLogo)
            return headerView
        } else {
            fatalError("Failed to dequeue header")
        }
    }
}

extension AmericanFootballViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMatch = leaguesData3[indexPath.section].matches[indexPath.row]
        delegate?.reactToCellTap(match: selectedMatch)
    }
}

extension AmericanFootballViewController: BaseViewProtocol{
    
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

private extension AmericanFootballViewController {
    
    func setupTableView() {
        tableView.register(
            MatchViewCell.self,
            forCellReuseIdentifier: MatchViewCell.identifier
        )
        
        tableView.register(
            LeagueInfoViewHeader.self,
            forHeaderFooterViewReuseIdentifier: LeagueInfoViewHeader.identifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}
