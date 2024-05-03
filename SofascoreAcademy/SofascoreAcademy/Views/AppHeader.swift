import Foundation
import UIKit
import SofaAcademic
import SnapKit

class AppHeader: BaseView {
    
    private let logoPath = "sofascore_lockup"
    private let headerButtonIconSettingsPath = "Icon Settings"
    private let headerButtonIconTrophyPath = "Icon Trophy"
    
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
        appLogo.image = UIImage(named: logoPath)
        appLogo.contentMode = .scaleAspectFit
        backgroundColor = Colors.colorPrimaryDefault
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
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
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
        headerButtonSettings.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
}

// MARK: Additional methods
private extension AppHeader {
    
    @objc func buttonClicked(_ sender: UIButton) {
        delegate?.reactToSetingsTap()
    }
}
