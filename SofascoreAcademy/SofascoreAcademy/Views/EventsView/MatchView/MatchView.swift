import Foundation
import SnapKit
import UIKit
import SofaAcademic

public enum TeamSide {
    case home
    case away
}

class MatchView: BaseView {
    
    private var homeTeam: String?
    private var homeTeamLogo: String?
    private var awayTeam: String?
    private var awayTeamLogo: String?
    private var matchId: Int = 0
    
    private var homeTeamLabel = TeamNameLogoView()
    private var awayTeamLabel = TeamNameLogoView()
    private var timeStatusView = TimeStatusView()
    private var homeResult = ScoreLabel()
    private var awayResult = ScoreLabel()
    private var divider = UIView()
    private var timeRect = UIView()
    
    override func addViews() {
        addSubview(timeRect)
        timeRect.addSubview(divider)
        timeRect.addSubview(timeStatusView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeResult)
        addSubview(awayResult)
    }
    
    override func styleViews() {
        backgroundColor = .white
        divider.backgroundColor = .onSurfaceOnSurfaceLv4
    }
    
    override func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(56)
        }
        
        timeRect.snp.makeConstraints() {
            $0.height.equalTo(56)
            $0.width.equalTo(64)
            $0.top.leading.equalToSuperview()
        }
        
        divider.snp.makeConstraints() {
            $0.leading.equalToSuperview().inset(63)
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        timeStatusView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.leading.equalToSuperview().inset(4)
        }
        
        homeTeamLabel.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(timeRect.snp.trailing).offset(16)
        }
        
        awayTeamLabel.snp.makeConstraints() {
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
            $0.leading.equalTo(timeRect.snp.trailing).offset(16)
        }
        
        homeResult.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        awayResult.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: Additional methods
extension MatchView {
    
    func update(data: Event) {
        matchId = data.id
        
        homeTeamLabel.update(
            teamId: data.homeTeam.id,
            teamName: data.homeTeam.name,
            teamLogo: UIImage(),
            color: Helpers.determineHomeTeamTextColorBasedOnMatchStatus(matchWinner: data.winnerCode)
        )
        awayTeamLabel.update(
            teamId: data.awayTeam.id,
            teamName: data.awayTeam.name,
            teamLogo: UIImage(),
            color: Helpers.determineAwayTeamTextColorBasedOnMatchStatus(matchWinner: data.winnerCode)
        )
        homeResult.update(
            matchId: data.id,
            status: data.status,
            score: data.homeScore.total,
            color: Helpers.determineHomeTeamTextColorBasedOnMatchStatus(matchWinner: data.winnerCode)
        )
        awayResult.update(
            matchId: data.id,
            status: data.status,
            score: data.awayScore.total,
            color: Helpers.determineAwayTeamTextColorBasedOnMatchStatus(matchWinner: data.winnerCode)
        )
        timeStatusView.update(matchTime: Helpers.dateStringToTimestamp(data.startDate) ?? 0, status: data.status)
    }
    
    func updateScore(score: Int, side: TeamSide){
        if(side == .home) {
            homeResult.updateScore(score: score)
        }
        else if(side == .away) {
            awayResult.updateScore(score: score)
        }
    }
    
    func updateMatchTime(time: Int) {
        timeStatusView.updateMatchTime(time: time)
    }
}