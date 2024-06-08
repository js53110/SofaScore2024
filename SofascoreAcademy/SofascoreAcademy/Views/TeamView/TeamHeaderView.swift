import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamHeaderView: BaseView {
    
    private let backButtonContainer = UIView()
    private let backButtonImage = UIImageView()
    private let teamNameLabel = UILabel()
    
    private let countryNameLabel = UILabel()
    private let countryFlagImageView = UIImageView()
    
    private let teamImageView = UIImageView()
    private let teamLogoImageContainer = UIView()
    
    weak var eventDelegate: ReturnButtonDelegate?
    
    override func addViews() {
        addSubview(backButtonContainer)
        addSubview(teamLogoImageContainer)
        teamLogoImageContainer.addSubview(teamImageView)
        backButtonContainer.addSubview(backButtonImage)
        addSubview(teamNameLabel)
        addSubview(countryNameLabel)
        addSubview(countryFlagImageView)
    }
    
    override func styleViews() {
        backButtonImage.image = UIImage(named: "back_icon_white")
        backButtonImage.contentMode = .scaleAspectFit
        
        teamNameLabel.font = .headline1
        teamNameLabel.textColor = .surfaceSurface1
        
        countryNameLabel.font = .headline3
        countryNameLabel.textColor = .surfaceSurface1
        
        teamLogoImageContainer.backgroundColor = .onColorOnColorPrimary
        teamLogoImageContainer.layer.cornerRadius = 8
        
        teamImageView.contentMode = .scaleAspectFit
        countryFlagImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        backButtonContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
            $0.size.equalTo(48)
        }
        
        teamLogoImageContainer.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(48)
        }
        
        teamImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview().inset(8)
        }
        
        countryFlagImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(88)
            $0.top.equalToSuperview().inset(84)
            $0.size.equalTo(16)
        }
        
        backButtonImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(88)
            $0.top.equalToSuperview().inset(52)
            $0.bottom.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        countryNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(108)
            $0.top.equalToSuperview().inset(84)
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButtonContainer.addGestureRecognizer(tapGesture)
    }
}

extension TeamHeaderView {
    
    @objc func backButtonTapped() {
        eventDelegate?.reactToReturnTap()
    }
    
    func update(teamData: Team) {
        updateTeamLogo(teamId: teamData.id)
        updateCountryFlag(countryId: teamData.country.id)
        teamNameLabel.text = teamData.name
        countryNameLabel.text = teamData.country.name
    }
    
    private func updateTeamLogo(teamId: Int) {
        Task {
            do {
                teamImageView.image = await ImageService().getTeamLogo(teamId: teamId)
            }
        }
    }
    
    private func updateCountryFlag(countryId: Int) {
        Task {
            do {
                countryFlagImageView.image = await ImageService().getCountryFlag(countryId: countryId)
            }
        }
    }
}


