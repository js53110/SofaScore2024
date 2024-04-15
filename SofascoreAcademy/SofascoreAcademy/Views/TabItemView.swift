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

//extension TabItemView {
//    func createButton(logoString: String, title: String) -> UIButton {
//        let button = UIButton()
//        let buttonTitle = UILabel()
//        let buttonLogo = UIImageView()
//        
//        button.addSubview(buttonTitle)
//        button.addSubview(buttonLogo)
//        
//        buttonTitle.text = title
//        buttonTitle.textAlignment = .center
//        buttonTitle.textColor = .white
//        buttonTitle.font = fonts.RobotoRegular14
//        buttonLogo.image = UIImage(named: logoString)
//        
//        let tabWidth = UIScreen.main.bounds.width/3
//        
//        buttonLogo.snp.makeConstraints() {
//            $0.size.equalTo(16)
//            $0.top.equalToSuperview().offset(4)
//            $0.leading.equalToSuperview().offset(tabWidth/2-8)
//        }
//        
//        buttonTitle.snp.makeConstraints() {
//            $0.leading.trailing.equalToSuperview().inset(8)
//            $0.bottom.equalToSuperview().inset(8)
//            $0.top.equalToSuperview().offset(24)
//        }
//        
//        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        
//        return button
//    }
//}
//
//extension TabItemView {
//    
//    @objc func buttonClicked(_ sender: UIButton) {
//        let selectedSportSlug = sportSlug
//        delegate?.getPressedTab(selectedSportSlug: selectedSportSlug)
//    }
//}
