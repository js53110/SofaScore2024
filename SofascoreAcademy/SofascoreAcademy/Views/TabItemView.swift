import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TabItemView: BaseView {
    
    let sportSlug: sportSlug
    
    private let logoString: String
    private let title: String
    private let tabLogo = UIImageView()
    private let tabLabel = UILabel()
        
    init(sportSlug : sportSlug) {
        self.sportSlug = sportSlug
        (logoString, title) = helpers.determineTabButtonData(sportSlug: sportSlug)
        super.init()
    }
    
    override func addViews() {
        addSubview(tabLabel)
        addSubview(tabLogo)
    }
    
    override func styleViews() {
        tabLogo.image = UIImage(named: logoString)
        tabLabel.text = title
        tabLabel.textColor = .white
        tabLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        tabLogo.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(4)
        }
        
        tabLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }

}
