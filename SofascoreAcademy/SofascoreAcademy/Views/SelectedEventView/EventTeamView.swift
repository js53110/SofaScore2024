import Foundation
import SnapKit
import UIKit
import SofaAcademic

class EventTeamView: BaseView {
    
    private let teamLogoImageView = UIImageView()
    private let teamNameLabel = UILabel()
    
    weak var eventDelegate: ReturnButtonDelegate?
    weak var teamTapDelegate: TeamTapDelegate?
    
    private var teamId: Int?
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamNameLabel.font = .assistive
        teamNameLabel.textColor = .black
        teamNameLabel.textAlignment = .center
        teamNameLabel.numberOfLines = 0
        teamNameLabel.lineBreakMode = .byWordWrapping
    }
    
    override func setupConstraints() {
        teamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
}

//MARK: Additional methods
extension EventTeamView {
    
    func update(team: Team) {
        teamNameLabel.text = team.name
        teamId = team.id
    }
    
    func updateTeamLogo(teamId: Int) {
        Task {
            do {
                teamLogoImageView.image = await ImageService().getTeamLogo(teamId: teamId)
            }
        }
    }
    
    @objc private func handleTap() {
        teamTapDelegate?.reactToTeamTap(teamId: teamId ?? 0)
    }
}



