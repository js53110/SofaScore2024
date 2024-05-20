import Foundation
import SnapKit
import UIKit
import SofaAcademic

class EventTeamView: BaseView {
    
    private let teamLogoImageView = UIImageView()
    private let teamNameLabel = UILabel()
        
    weak var eventDelegate: ReturnButtonDelegate?
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamNameLabel.font = Fonts.RobotoBold12
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
}

extension EventTeamView {
    
    func updateTeamName(teamName: String) {
        teamNameLabel.text = teamName
    }

    func updateTeamLogo(teamLogo: UIImage) {
        teamLogoImageView.image = teamLogo
    }
}



