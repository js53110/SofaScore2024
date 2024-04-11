import UIKit
import SofaAcademic
import SnapKit
import Foundation

class CustomTabBarController: BaseView {
    
    let tabsContainerView = UIView()
    var tab1View = UIButton()
    var tab2View = UIButton()
    var tab3View = UIButton()
    var n = 1
    var tabIndicator = UIView()
    
    var delegate: parentSportSlugPicker?
    
    override func addViews() {
        addSubview(tabsContainerView)
        
        tab1View = createButton(logoString: "Icon", title: "Football")
        tab2View = createButton(logoString: "icon_basketball", title: "Basketball")
        tab3View = createButton(logoString: "icon_american_football", title: "Am. Football")
        
        tabsContainerView.addSubview(tab1View)
        tabsContainerView.addSubview(tab2View)
        tabsContainerView.addSubview(tab3View)
        tabsContainerView.addSubview(tabIndicator)
    }
    
    override func styleViews() {
        backgroundColor = colors.colorPrimaryDefault
        tabIndicator.backgroundColor = .white
        tabIndicator.layer.cornerRadius = 2
    }
    
    override func setupConstraints() {
        tabsContainerView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        tabIndicator.snp.makeConstraints() {
            $0.height.equalTo(4)
            $0.width.equalTo(115)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo((n-1)*131+8)
        }
        
        let tabWidth = UIScreen.main.bounds.width/3
        tab1View.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tabWidth)
            $0.leading.equalToSuperview()
        }
        
        tab2View.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tabWidth)
            $0.leading.equalTo(tab1View.snp.trailing)
        }
        
        tab3View.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tabWidth)
            $0.leading.equalTo(tab2View.snp.trailing)
        }
    }
}

extension CustomTabBarController{
    
    func createButton(logoString: String, title: String) -> UIButton {
        let button = UIButton()
        let buttonTitle = UILabel()
        let buttonLogo = UIImageView()
        
        button.addSubview(buttonTitle)
        button.addSubview(buttonLogo)
        
        buttonTitle.text = title
        buttonTitle.textAlignment = .center
        buttonTitle.textColor = .white
        buttonTitle.font = fonts.RobotoRegular14
        buttonLogo.image = UIImage(named: logoString)
        
        let tabWidth = UIScreen.main.bounds.width/3
        
        buttonLogo.snp.makeConstraints() {
            $0.size.equalTo(16)
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(tabWidth/2-8)
        }
        
        buttonTitle.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.top.equalToSuperview().offset(24)
        }
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        return button
    }
}

extension CustomTabBarController {
    
    @objc func buttonClicked(_ sender: UIButton) {
        var selectedSportSlug: sportSlug? = nil
        if sender == tab1View {
            selectedSportSlug = .football
            n = 1
        } else if sender == tab2View {
            selectedSportSlug = .basketball
            n = 2
        } else if sender == tab3View {
            selectedSportSlug = .americanFootball
            n = 3
        }
        UIView.animate(withDuration: 0.3) {
            self.tabIndicator.snp.remakeConstraints() {
                $0.height.equalTo(4)
                $0.width.equalTo(115)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo((self.n - 1) * 131 + 8)
            }
            self.layoutIfNeeded()
        }
        delegate?.getPressedTab(selectedSportSlug: selectedSportSlug)
    }
}
