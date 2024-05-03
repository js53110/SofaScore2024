import UIKit
import SnapKit
import SofaAcademic

class SportViewController: UIViewController {
    
    private let tableView = UITableView()
    private var data: Array<LeagueInfo>
    weak var delegate: MatchTapDelegate?
    
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
        setupTableView()
    }
}

// MARK: UITableViewDataSource
extension SportViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].matches.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.identifier,
            for: indexPath) as? MatchViewCell {
            let dataForRow = data[indexPath.section].matches[indexPath.row]
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
                countryName: sectionData.countryName,
                leagueName: sectionData.leagueName,
                leagueLogo: sectionData.leagueLogo)
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
        let selectedMatch = data[indexPath.section].matches[indexPath.row]
        delegate?.displayMatchInfoOnTap(selectedMatch: selectedMatch)
    }
}

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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}
