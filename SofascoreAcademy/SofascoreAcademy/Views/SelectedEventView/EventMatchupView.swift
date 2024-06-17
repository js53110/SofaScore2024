import Foundation
import SnapKit
import UIKit
import SofaAcademic

class EventMatchupView: BaseView {
    
    private let homeTeamView = EventTeamView()
    private let awayTeamView = EventTeamView()
    private var homeTeam: Team?
    private var awayTeam: Team?
    
    private let scoreView = EventScoreView()
    
    weak var teamTapDelegate: TeamTapDelegate?
    
    override func addViews() {
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(scoreView)
        
        homeTeamView.teamTapDelegate = self
        awayTeamView.teamTapDelegate = self
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

//MARK: Additional methods
extension EventMatchupView {
    
    func updateTeamNames(homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        homeTeamView.update(team: homeTeam)
        awayTeamView.update(team: awayTeam)
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

//MARK: TeamTapDelegate
extension EventMatchupView: TeamTapDelegate {
    func reactToTeamTap(teamId: Int) {
        teamTapDelegate?.reactToTeamTap(teamId: teamId)
    }
}
