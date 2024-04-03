import UIKit
import SnapKit

class LeagueInfoViewCell: UITableViewHeaderFooterView {
        
    let leagueInfoView = LeagueInfoView()
    static let identifier = "leagueHeader"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(countryName: String, leagueName: String, leagueLogo: String) {
        leagueInfoView.update(countryName: countryName, leagueName: leagueName, leagueLogo: leagueLogo)
    }
    
    func addViews() {
        contentView.addSubview(leagueInfoView)
    }
    
    func setupConstraints() {
        leagueInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}
