import Foundation
import SnapKit
import UIKit
import SofaAcademic

class EventHeader: BaseView {
    
    private let leagueLogoView = UIImageView()
    private let leagueInfoText = UILabel()
    
    private let backButtonContainer = UIView()
    private let backButtonImage = UIImageView()
    
    private var matchData: Event?
    
    weak var eventDelegate: ReturnButtonDelegate?
    weak var tournamentTapDelegate: LeagueTapDelegate?
    
    override func addViews() {
        addSubview(backButtonContainer)
        backButtonContainer.addSubview(backButtonImage)
        addSubview(leagueLogoView)
        addSubview(leagueInfoText)
    }
    
    override func styleViews() {
        backButtonImage.image = UIImage(named: "back_icon_black")
        backButtonImage.contentMode = .scaleAspectFit
        
        leagueLogoView.contentMode = .scaleAspectFit
        
        leagueInfoText.textColor = .onSurfaceOnSurfaceLv2
        leagueInfoText.font = .micro
    }
    
    override func setupConstraints() {
        backButtonContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
            $0.size.equalTo(48)
        }
        
        backButtonImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        leagueLogoView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(64)
            $0.size.equalTo(16)
        }
        
        leagueInfoText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(leagueLogoView.snp.trailing).offset(8)
            $0.height.equalTo(16)
        }
    }
    override func setupGestureRecognizers() {
        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        let tournamentTapGesture = UITapGestureRecognizer(target: self, action: #selector(tournamentTapped))
        
        backButtonContainer.addGestureRecognizer(backButtonTapGesture)
        addGestureRecognizer(tournamentTapGesture)
    }
    
    @objc func backButtonTapped() {
        eventDelegate?.reactToReturnTap()
    }
    
    @objc func tournamentTapped() {
        tournamentTapDelegate?.reactToLeagueHeaderTap(tournamentId: matchData?.tournament.id ?? 0)
    }
}

//MARK: Additional methods
extension EventHeader {
    
    func update(matchData: Event) {
        self.matchData = matchData
        leagueInfoText.text = "\(matchData.tournament.sport.name), \(matchData.tournament.country.name), \(matchData.tournament.name), Round \(matchData.round)"
    }
    
    func updateLeagueLogo(tournamentId: Int) {
        Task {
            do {
                leagueLogoView.image = await ImageService().getLeagueLogo(tournamentId: tournamentId)
            }
        }
    }
}



