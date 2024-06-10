import Foundation
import UIKit
import SofaAcademic
import SnapKit

class AppHeader: BaseView {
    
    private let logoPath = "sofascore_logo"
    private let headerButtonIconSettingsPath = "icon_settings"
    private let headerButtonIconTrophyPath = "icon_trophy"
    
    private let appLogo = UIImageView()
    private let headerButtonTrophy = UIButton()
    private let headerButtonSettings = UIButton()
    private let headerIconSettings = UIImageView()
    private let headerIconTrophy = UIImageView()
    
    weak var delegate: AppHeaderDelegate?
    
    override func addViews() {
        addSubview(appLogo)
        addSubview(headerButtonTrophy)
        addSubview(headerButtonSettings)
        
        headerButtonSettings.addSubview(headerIconSettings)
        headerButtonTrophy.addSubview(headerIconTrophy)
    }
    
    override func styleViews() {
        backgroundColor = .colorPrimaryDefault
        appLogo.image = UIImage(named: logoPath)
        appLogo.contentMode = .scaleAspectFit
        headerIconTrophy.image = UIImage(named: headerButtonIconTrophyPath)
        headerIconSettings.image = UIImage(named: headerButtonIconSettingsPath)
    }
    
    override func setupConstraints() {
        snp.makeConstraints(){
            $0.height.equalTo(48)
        }
        
        appLogo.snp.makeConstraints() {
            $0.height.equalTo(20)
            $0.width.equalTo(132)
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        
        headerButtonSettings.snp.makeConstraints() {
            $0.size.equalTo(48)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(4)
        }
        
        headerButtonTrophy.snp.makeConstraints() {
            $0.size.equalTo(48)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(52)
        }
        
        headerIconSettings.snp.makeConstraints() {
            $0.size.equalTo(24)
            $0.edges.equalToSuperview().inset(12)
        }
        
        headerIconTrophy.snp.makeConstraints() {
            $0.size.equalTo(24)
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    override func setupGestureRecognizers() {
        headerButtonSettings.addTarget(self, action: #selector(buttonSettingsClicked), for: .touchUpInside)
        headerButtonTrophy.addTarget(self, action: #selector(buttonTrophyClicked), for: .touchUpInside)
    }
}

// MARK: Private methods
private extension AppHeader {
    
    @objc func buttonSettingsClicked(_ sender: UIButton) {
        delegate?.reactToSetingsTap()
    }
    
    @objc func buttonTrophyClicked(_ sender: UIButton) {
        delegate?.reactToTrophyTap()
    }
}
