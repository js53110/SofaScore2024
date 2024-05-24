import Foundation
import SnapKit
import UIKit
import SofaAcademic

class EventMatchupView: BaseView {
    
    private let homeTeamView = EventTeamView()
    private let awayTeamView = EventTeamView()
    
    private let scoreView = EventScoreView()
        
    weak var eventDelegate: ReturnButtonDelegate?
    
    override func addViews() {
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(scoreView)
    }
    
    override func styleViews() {
        
    }
    
    override func setupConstraints() {
        homeTeamView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(96)
        }
        
        awayTeamView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(96)
        }
        
        scoreView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.equalTo(homeTeamView.snp.trailing)
            $0.trailing.equalTo(awayTeamView.snp.leading)
            $0.top.equalToSuperview().offset(16)
        }
    }
}

extension EventMatchupView {
    
    func updateTeamNames(homeTeamName: String, awayTeamName: String) {
        homeTeamView.updateTeamName(teamName: homeTeamName)
        awayTeamView.updateTeamName(teamName: awayTeamName)
    }
    
    func updateHomeTeamLogo(teamId: Int) {
        homeTeamView.updateTeamLogo(teamId: teamId)
    }
    
    func updateAwayTeamLogo(teamId: Int) {
        awayTeamView.updateTeamLogo(teamId: teamId)
    }
    
    func updateScoreView(matchData: Event) {
        scoreView.update(matchData: matchData)
    }
}



