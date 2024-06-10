import UIKit
import SofaAcademic
import SnapKit
import Foundation

class TournamentCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let leagueLogo = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Class methods
extension TournamentCell {
    
    private func setupViews() {
        addViews()
        styleViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(nameLabel)
        addSubview(leagueLogo)
    }
    
    private func styleViews() {
        selectionStyle = .none
        nameLabel.font = .headline3
        backgroundColor = .white
        nameLabel.textColor = .onSurfaceOnSurfaceLv1
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(72)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(20)
        }
        
        leagueLogo.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    func update(tournament: Tournament) {
        nameLabel.text = tournament.name
        updateLeagueLogo(tournamentId: tournament.id)
    }
    
    func updateLeagueLogo(tournamentId: Int) {
        Task {
            do {
                leagueLogo.image = await ImageService().getLeagueLogo(tournamentId: tournamentId)
            }
        }
    }
}
