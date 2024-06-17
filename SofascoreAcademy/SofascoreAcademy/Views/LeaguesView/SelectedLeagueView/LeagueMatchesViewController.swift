import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LeagueMatchesViewController: UIViewController {
    
    private var leagueEvents: [[Event]] = []
    private let tableView = UITableView()
    
    init(leagueEvents: [[Event]]) {
        self.leagueEvents = leagueEvents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

//MARK: Private methods
extension LeagueMatchesViewController {
    
    private func setupViews() {
        addViews()
        styleViews()
        setupConstraints()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MatchViewCell.self, forCellReuseIdentifier: MatchViewCell.identifier)
        tableView.register(RoundMatchesHeaderView.self, forHeaderFooterViewReuseIdentifier: RoundMatchesHeaderView.identifier)
        tableView.separatorStyle = .none
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

//MARK: BaseViewProtocol
extension LeagueMatchesViewController: BaseViewProtocol {
    func addViews() {
        view.addSubview(tableView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: UITableViewDataSource
extension LeagueMatchesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagueEvents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueEvents[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchViewCell.identifier, for: indexPath) as! MatchViewCell
        let event = leagueEvents[indexPath.section][indexPath.row]
        if (event.status != "finished") {
            cell.update(data: event, displayDate: true)
        } else {
            cell.update(data: event, displayDate: false)
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension LeagueMatchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RoundMatchesHeaderView.identifier) as! RoundMatchesHeaderView
        header.update(count: leagueEvents[section].count, date: "Round \(leagueEvents[section].first?.round ?? 0)")
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = leagueEvents[indexPath.section][indexPath.row]
        navigationController?.pushViewController(EventDataViewController(matchData: match), animated: true)
    }
}

//MARK: UIGestureRecognizerDelegate
extension LeagueMatchesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
