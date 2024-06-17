import UIKit
import SofaAcademic
import SnapKit
import Foundation

class CustomLeagueTabView: BaseView {
    
    static let matchesTitle = "Matches"
    
    private let stackView = UIStackView()
    private var tabButtonMatches = TeamLeagueTabItemView(title: CustomTeamTabView.matchesTitle)
    private var tabButtonStandings = TeamLeagueTabItemView(title: CustomTeamTabView.standingsTitle)
    private var tabIndicator = UIView()
    private var selectedTab: TeamLeagueTabItemView
    
    weak var delegate: TeamTournamentTabSelectDelegate?
    
    override init(){
        selectedTab = tabButtonMatches
        super.init()
    }
    
    override func addViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(tabButtonMatches)
        stackView.addArrangedSubview(tabButtonStandings)
        stackView.addSubview(tabIndicator)
    }
    
    override func styleViews() {
        backgroundColor = .colorPrimaryDefault
        stackView.distribution = .fillEqually
        tabIndicator.backgroundColor = .white
        tabIndicator.layer.cornerRadius = 2
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        tabIndicator.snp.makeConstraints() {
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(selectedTab.snp.trailing).inset(8)
            $0.leading.equalTo(selectedTab.snp.leading).offset(8)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapMatches = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
        tabButtonMatches.addGestureRecognizer(tapMatches)
        
        let tabStandings = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
        tabButtonStandings.addGestureRecognizer(tabStandings)
    }
}

//MARK: Private methods
private extension CustomLeagueTabView {
    
    @objc func tabTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedButton = sender.view as? TeamLeagueTabItemView else { return }
        delegate?.reactToTeamTournamentTabSelect(tabTitle: tappedButton.title)
        moveIndicator(selectedTab: tappedButton)
    }
    
    func moveIndicator(selectedTab: TeamLeagueTabItemView) {
        
        UIView.animate(withDuration: 0.3) {
            self.tabIndicator.snp.remakeConstraints {
                $0.height.equalTo(4)
                $0.bottom.equalToSuperview()
                $0.trailing.equalTo(selectedTab.snp.trailing).inset(8)
                $0.leading.equalTo(selectedTab.snp.leading).offset(8)
            }
            self.layoutIfNeeded()
        }
    }
}

