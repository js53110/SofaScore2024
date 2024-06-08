import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TournamentCardViewCell: UICollectionViewCell {
    
    static let identifier = "TournamentViewCell"
    
    private let tournamentImageView = UIImageView()
    private let tournamentNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        addViews()
        styleViews()
        setupConstraints()
    }
}

extension TournamentCardViewCell: BaseViewProtocol {
    func addViews() {
        addSubview(tournamentImageView)
        addSubview(tournamentNameLabel)
    }
    
    func styleViews() {
        tournamentImageView.contentMode = .scaleAspectFit
        
        tournamentNameLabel.textColor = .onSurfaceOnSurfaceLv2
        tournamentNameLabel.font = .micro
    }
    
    func setupConstraints() {
        tournamentImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }
        
        tournamentNameLabel.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(52)
        }
    }
}

extension TournamentCardViewCell {
    
    func setupCell(tournament: Tournament) {
        tournamentNameLabel.text = tournament.name
        updateTournamentImage(tournamentId: tournament.id)
    }
    
    private func updateTournamentImage(tournamentId: Int) {
        Task {
            do {
                tournamentImageView.image = await ImageService().getLeagueLogo(tournamentId: tournamentId)
            }
        }
    }
}
