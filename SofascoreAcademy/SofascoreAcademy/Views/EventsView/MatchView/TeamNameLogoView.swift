import Foundation
import SnapKit
import UIKit
import SofaAcademic

class TeamNameLogoView: BaseView {
    
    private let teamNameLabel = UILabel()
    private let teamLogoImageView = UIImageView()
    
    override func addViews() {
        addSubview(teamNameLabel)
        addSubview(teamLogoImageView)
    }
    
    override func styleViews() {
        teamNameLabel.font = Fonts.RobotoRegular14
        teamLogoImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(16)
            $0.width.equalTo(216)
        }
        
        teamNameLabel.snp.makeConstraints() {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(teamLogoImageView.snp.trailing).offset(8)
        }
        
        teamLogoImageView.snp.makeConstraints() {
            $0.top.bottom.leading.equalToSuperview()
            $0.height.width.equalTo(16)
        }
    }
}

//MARK: Additional methods
extension TeamNameLogoView {
    
    func update(teamId: Int, teamName: String, teamLogo: UIImage, color: UIColor) {
        updateTeamLogo(teamId: teamId)
        teamNameLabel.text = teamName
        teamLogoImageView.image = teamLogo
        teamNameLabel.textColor = color
    }
    
    func updateTeamLogo(teamId: Int) {
        Task {
            do {
                teamLogoImageView.image = await ImageService().getTeamLogo(teamId: teamId)
            }
        }
    }
}
