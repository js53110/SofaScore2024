import UIKit
import Foundation
import SnapKit
import SofaAcademic

class LeagueInfoViewHeader: UITableViewHeaderFooterView {

    private let leagueInfoView = LeagueInfoView()
    static let identifier = "leagueHeader"
    private var tournamentId: Int?
    
    weak var delegate: LeagueTapDelegate?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        setupGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func headerTapped() {
        delegate?.reactToLeagueHeaderTap(tournamentId: tournamentId ?? 0)
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
    
    func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
}

//MARK: Additional methods
extension LeagueInfoViewHeader {

    func update(countryName: String, leagueName: String, tournamentId: Int) {
        self.tournamentId = tournamentId
        leagueInfoView.update(countryName: countryName, leagueName: leagueName, tournamentId: tournamentId)
    }
}
