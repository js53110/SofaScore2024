import Foundation
import SnapKit
import UIKit
import SofaAcademic

class EventScoreView: BaseView {
    
    private let score = UIView()
    private let matchStartTime = UILabel()
    private let time = UILabel()
    
    private let homeTeamScore = UILabel()
    private let divider = UILabel()
    private let awayTeamScore = UILabel()
        
    override func addViews() {
        addSubview(score)
        
        score.addSubview(homeTeamScore)
        score.addSubview(divider)
        score.addSubview(awayTeamScore)
        
        addSubview(matchStartTime)
        addSubview(time)
    }
    
    override func styleViews() {
        homeTeamScore.font = Fonts.RobotoBold32
        homeTeamScore.textAlignment = .right
        homeTeamScore.textColor = .black
        
        divider.font = Fonts.RobotoBold32
        divider.textAlignment = .center
        divider.textColor = Colors.surfaceLv2
        
        awayTeamScore.font = Fonts.RobotoBold32
        awayTeamScore.textAlignment = .left
        awayTeamScore.textColor = .black
        
        time.font = Fonts.RobotoCondensedRegularMicro
        time.textColor = .black
        time.textAlignment = .center
        
        matchStartTime.font = Fonts.RobotoCondensedRegularMicro
        matchStartTime.textColor = .black
        matchStartTime.textAlignment = .center

    }
    
    override func setupConstraints() {
        score.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        divider.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.width.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        homeTeamScore.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(divider.snp.leading).offset(-4)
        }
        
        awayTeamScore.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(divider.snp.trailing).offset(4)
        }
        
        time.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        matchStartTime.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.bottom.equalTo(time.snp.top).offset(-4) //inset 4 ne radi
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension EventScoreView {
    
    func update(matchData: Event) {
        if matchData.status == "finished" {
            if let homeScoreTotal = matchData.homeScore.total {
                homeTeamScore.text = String(homeScoreTotal)
            }
            
            if let awayScoreTotal = matchData.awayScore.total {
                awayTeamScore.text = String(awayScoreTotal)
            }
            
            time.text = "Full time"
            time.textColor = Colors.surfaceLv2
            divider.text = "-"
            
            if matchData.winnerCode == "home" {
                awayTeamScore.textColor = Colors.surfaceLv2
            } else if matchData.winnerCode == "away" {
                homeTeamScore.textColor = Colors.surfaceLv2
            }
        } else {
            matchStartTime.text = Helpers.convertTimeStampStringToDate(dateString: matchData.startDate)
            time.text = Helpers.convertTimeStampStringToTime(dateString: matchData.startDate)
        }
    }


}



