import Foundation
import UIKit
import SnapKit
import SofaAcademic

class PlayerTeamView: BaseView {
    
    private let teamNameLabel = UILabel()
    private let teamLogoImageView = UIImageView()
    
    override func addViews() {
        addSubview(teamNameLabel)
        addSubview(teamLogoImageView)
    }
    
    override func styleViews() {
        teamNameLabel.font = .headline3
        teamNameLabel.textColor = .onSurfaceOnSurfaceLv1
        teamLogoImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        teamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(72)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    func update(team: Country) {
        teamNameLabel.text = team.name
        updateTeamImage(teamId: team.id)
    }
    
    private func updateTeamImage(teamId: Int) {
        Task {
            do {
                teamLogoImageView.image = await ImageService().getCountryFlag(countryId: teamId)
            }
        }
    }
}
