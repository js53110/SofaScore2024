import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LeagueInfoViewHeader: UITableViewHeaderFooterView {
    
    private let leagueInfoView = LeagueInfoView()
    static let identifier = "leagueHeader"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: BaseViewProtocol
extension LeagueInfoViewHeader: BaseViewProtocol {
    
    func addViews() {
        contentView.addSubview(leagueInfoView)
    }
    
    func setupConstraints() {
        leagueInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().priority(999)
        }
    }
}

//MARK: Additional methods
extension LeagueInfoViewHeader {
    
    func update(countryName: String, leagueName: String, tournamentId: Int) {
        leagueInfoView.update(countryName: countryName, leagueName: leagueName, tournamentId: tournamentId)
    }
}
