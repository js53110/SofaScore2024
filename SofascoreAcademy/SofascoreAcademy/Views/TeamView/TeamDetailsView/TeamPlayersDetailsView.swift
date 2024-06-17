import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamPlayersDetailsView: BaseView {
    
    private let topDvider = CustomDivider()
    private let bottomDivider = CustomDivider()
    private let stackView = UIStackView()
    private let totalPlayersView = TeamDetailsPlayersCard()
    private let foreignPlayersView = TeamDetailsPlayersCard()
    
    override init () {
        super.init()
        
    }
    
    override func addViews() {
        addSubview(topDvider)
        addSubview(stackView)
        stackView.addArrangedSubview(totalPlayersView)
        stackView.addArrangedSubview(foreignPlayersView)
        addSubview(bottomDivider)
    }
    
    override func styleViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
    }
    
    override func setupConstraints() {
        topDvider.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(topDvider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        totalPlayersView.snp.makeConstraints {
            $0.height.equalTo(116)
        }
        
        foreignPlayersView.snp.makeConstraints {
            $0.height.equalTo(116)
        }
        
        bottomDivider.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: Additional methods
extension TeamPlayersDetailsView {
    
    func update(teamPlayers: [Player], country: Country) {
        totalPlayersView.update(image: UIImage(named: "ic_team") ?? UIImage(),
                                playersCount: teamPlayers.count,
                                descriptionText: "Total Players")
        
        let foreignPlayersCount = teamPlayers.filter { $0.country.id != country.id }.count
        
        foreignPlayersView.update(image: UIImage(named: "ic_team") ?? UIImage(),
                                  playersCount: foreignPlayersCount,
                                  descriptionText: "Foreign players")
    }
}
