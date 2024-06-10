import Foundation
import SnapKit
import UIKit
import SofaAcademic


class IncidentGoalView: UIView {
    
    private var incidentId: Int?
    private var player: Player?
    private var time: String?
    private var homeScore: Int?
    private var awayScore: Int?
    private var scoringTeam: String?
    private var goalType: String?
    
    private var divider = UIView()
    
    private let incidentIcon = UIImageView()
    private let playerName = UILabel()
    private let timeLabel = UILabel()
    
    private let scoreView = UIView()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let lineLabel = UILabel()
    
}

// MARK: Additional methods
extension IncidentGoalView: IncidentViewProtocol {
    
    func update(data: EventIncident, matchData: Event) {
        incidentId = data.id
        player = data.player
        time = String(data.time)
        scoringTeam = data.scoringTeam
        homeScore = data.homeScore
        awayScore = data.awayScore
        goalType = data.goalType
        
        addViews()
        styleViews()
        setupConstraints()
    }
}

extension IncidentGoalView: BaseViewProtocol {
    
    func addViews() {
        addSubview(divider)
        addSubview(incidentIcon)
        addSubview(playerName)
        addSubview(timeLabel)
        addSubview(scoreView)
        scoreView.addSubview(homeScoreLabel)
        scoreView.addSubview(lineLabel)
        scoreView.addSubview(awayScoreLabel)
    }
    
    func styleViews() {
        backgroundColor = .white
        divider.backgroundColor = .onSurfaceOnSurfaceLv4
        
        incidentIcon.contentMode = .scaleAspectFit
        
        homeScoreLabel.text = "\(homeScore ?? 0)"
        homeScoreLabel.textAlignment = .right
        homeScoreLabel.textColor = .black
        homeScoreLabel.font = .headline1
        
        awayScoreLabel.text = "\(awayScore ?? 0)"
        awayScoreLabel.textAlignment = .left
        awayScoreLabel.textColor = .black
        awayScoreLabel.font = .headline1
        
        lineLabel.text = "-"
        lineLabel.font = .headline1
        lineLabel.textColor = .black
        lineLabel.textAlignment = .center
        
        timeLabel.text = "\(time ?? "")" + "'"
        timeLabel.textAlignment = .center
        timeLabel.textColor = .onSurfaceOnSurfaceLv2
        timeLabel.font = .micro
        
        playerName.text = player?.name
        playerName.font = .body
        playerName.textColor = .black
        
        if (scoringTeam == "away") {
            playerName.textAlignment = .right
        }
        
        switch goalType {
        case "owngoal":
            incidentIcon.image = UIImage(named: "icon_autogoal")
        case "penalty":
            incidentIcon.image = UIImage(named: "icon_penalty")
        case "onepoint":
            incidentIcon.image = UIImage(named: "icon_onepoint")
            homeScoreLabel.font = .headline3
            awayScoreLabel.font = .headline3
        case "twopoint":
            incidentIcon.image = UIImage(named: "icon_twopoint")
            homeScoreLabel.font = .headline3
            awayScoreLabel.font = .headline3
        case "threepoint":
            incidentIcon.image = UIImage(named: "icon_threepoint")
            homeScoreLabel.font = .headline3
            awayScoreLabel.font = .headline3
        case "fieldgoal":
            incidentIcon.image = UIImage(named: "icon_fieldgoal")
        case "extrapoint":
            incidentIcon.image = UIImage(named: "icon_extrapoint")
        case "touchdown":
            incidentIcon.image = UIImage(named: "icon_touchdown")
        default:
            incidentIcon.image = UIImage(named: "icon_goal")
        }
        
    }
    
    func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(56)
        }
        
        if(scoringTeam == "home") {
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
            
            scoreView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(64)
                $0.top.equalToSuperview().inset(14)
                $0.height.equalTo(28)
                $0.width.equalTo(84)
            }
            
            playerName.snp.makeConstraints {
                $0.top.equalToSuperview().inset(20)
                $0.leading.equalTo(scoreView.snp.trailing).offset(8)
                $0.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(20)
            }
            
            timeLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(8)
                $0.top.equalToSuperview().inset(32)
                $0.bottom.equalToSuperview().inset(8)
                $0.width.equalTo(40)
            }
        } else if (scoringTeam == "away") {
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
            
            scoreView.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(64)
                $0.top.equalToSuperview().inset(14)
                $0.height.equalTo(28)
                $0.width.equalTo(84)
            }
            
            playerName.snp.makeConstraints {
                $0.top.equalToSuperview().inset(20)
                $0.trailing.equalTo(scoreView.snp.trailing).inset(92)
                $0.leading.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(20)
            }
            
            timeLabel.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(8)
                $0.top.equalToSuperview().inset(32)
                $0.bottom.equalToSuperview().inset(8)
                $0.width.equalTo(40)
            }
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        lineLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(12)
            $0.centerY.equalToSuperview()
        }
    }
}
