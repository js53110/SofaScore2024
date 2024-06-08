import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamCoachDetailsView: BaseView {
    
    private let coachNameLabel = UILabel()
    private let coachCountryLabel = UILabel()
    private let countryFlagImageView = UIImageView()
    private let coachImageView = UIImageView()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(coachNameLabel)
        addSubview(coachImageView)
        addSubview(countryFlagImageView)
        addSubview(coachCountryLabel)
    }
    
    override func styleViews() {
        coachNameLabel.textAlignment = .left
        coachNameLabel.font = .body
        
        coachCountryLabel.font = .assistive
        coachCountryLabel.textColor = .onSurfaceOnSurfaceLv2
        coachCountryLabel.textAlignment = .left
        
        coachImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        coachImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        coachNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(72)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        countryFlagImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(72)
        }
        
        coachCountryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(92)
            $0.trailing.equalToSuperview().inset(200)
            $0.top.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

extension TeamCoachDetailsView {
    
    private func updateCountryFlag(countryId: Int) {
        Task {
            do {
                countryFlagImageView.image = await ImageService().getCountryFlag(countryId: countryId)
            }
        }
    }
    
    private func updateCoachImage(coachId: Int) {
        Task {
            do {
                coachImageView.image = await ImageService().getCoachImage(coachId: coachId)
            }
        }
    }
    
    func update(coachName: String, country: Country) {
        coachNameLabel.text = "Coach: \(coachName)"
        coachCountryLabel.text = country.name
        updateCountryFlag(countryId: country.id)
        updateCoachImage(coachId: 0)
    }
}
