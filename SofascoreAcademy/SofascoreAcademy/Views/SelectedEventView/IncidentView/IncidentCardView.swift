import Foundation
import SnapKit
import UIKit
import SofaAcademic

class IncidentCardView: UIView, IncidentViewProtocol {
    
    private var incidentId: Int?
    private var player: Player?
    private var teamSide: String?
    private var time: String?
    private var type: String?
    private var color: String?
    private var homeScore: Int?
    private var awayScore: Int?
    private var scoringTeam: String?
    private var goalType: String?
    
    private var divider = UIView()
    private var timeRect = UIView()
    
    private let incidentIcon = UIImageView()
    private let playerName = UILabel()
    private let incidentDescription = UILabel()
    private let timeLabel = UILabel()
    
    func addViews() {
        addSubview(divider)
        addSubview(incidentIcon)
        addSubview(timeLabel)
        addSubview(playerName)
        addSubview(incidentDescription)
    }
    
    func styleViews() {
        backgroundColor = .white
        divider.backgroundColor = .onSurfaceOnSurfaceLv4
        
        incidentIcon.contentMode = .scaleAspectFit
        
        if(color == "yellow") {
            incidentIcon.image = UIImage(named: "card_yellow")
        } else {
            incidentIcon.image = UIImage(named: "card_red")
        }
        
        timeLabel.text = "\(time ?? "")" + "'"
        timeLabel.textAlignment = .center
        timeLabel.textColor = .onSurfaceOnSurfaceLv2
        timeLabel.font = .micro
        
        incidentDescription.text = "Foul"
        
        playerName.text = player?.name
        playerName.font = .body
        playerName.textColor = .black
        
        if(teamSide == "away") {
            playerName.textAlignment = .right
            incidentDescription.textAlignment = .right
        }
        
        incidentDescription.font = .micro
        incidentDescription.textColor = .onSurfaceOnSurfaceLv2
        
    }
    
    func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(56)
        }
        
        if (teamSide == "home") {
            divider.snp.makeConstraints() {
                $0.leading.equalToSuperview().inset(55)
                $0.width.equalTo(1)
                $0.top.bottom.equalToSuperview().inset(8)
            }
            
            incidentIcon.snp.makeConstraints {
                $0.top.equalToSuperview().inset(8)
                $0.leading.equalToSuperview().inset(16)
                $0.size.equalTo(24)
            }
            
            playerName.snp.makeConstraints {
                $0.top.equalToSuperview().inset(12)
                $0.leading.equalToSuperview().inset(68)
                $0.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(28)
            }
            
            incidentDescription.snp.makeConstraints {
                $0.top.equalToSuperview().inset(28)
                $0.leading.equalToSuperview().inset(68)
                $0.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(12)
            }
            
            timeLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(8)
                $0.top.equalToSuperview().inset(32)
                $0.bottom.equalToSuperview().inset(8)
                $0.width.equalTo(40)
            }
        } else if(teamSide == "away") {
            
            divider.snp.makeConstraints() {
                $0.trailing.equalToSuperview().inset(55)
                $0.width.equalTo(1)
                $0.top.bottom.equalToSuperview().inset(8)
            }
            
            incidentIcon.snp.makeConstraints {
                $0.top.equalToSuperview().inset(8)
                $0.trailing.equalToSuperview().inset(16)
                $0.size.equalTo(24)
            }
            
            playerName.snp.makeConstraints {
                $0.top.equalToSuperview().inset(12)
                $0.trailing.equalToSuperview().inset(68)
                $0.leading.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(28)
            }
            
            incidentDescription.snp.makeConstraints {
                $0.top.equalToSuperview().inset(28)
                $0.trailing.equalToSuperview().inset(68)
                $0.leading.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(12)
            }
            
            timeLabel.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(8)
                $0.top.equalToSuperview().inset(32)
                $0.bottom.equalToSuperview().inset(8)
                $0.width.equalTo(40)
            }
            
        }
    }
}

// MARK: Additional methods
extension IncidentCardView {
    
    func update(data: EventIncident, matchData: Event) {
        incidentId = data.id
        player = data.player
        teamSide = data.teamSide
        time = String(data.time)
        color = data.color
        self.type = data.type
        scoringTeam = data.scoringTeam
        homeScore = data.homeScore
        awayScore = data.awayScore
        goalType = data.goalType
        
        addViews()
        styleViews()
        setupConstraints()
    }
}
