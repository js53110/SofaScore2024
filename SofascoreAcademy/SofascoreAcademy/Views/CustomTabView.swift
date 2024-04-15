import UIKit
import SofaAcademic
import SnapKit
import Foundation

class CustomTabView: BaseView {
    
    let tabsContainerView = UIView()
    var tabButtonFootball = TabItemView(sportSlug: .football)
    var tabButtonBasketball = TabItemView(sportSlug: .basketball)
    var tabButtonAmericanFootball = TabItemView(sportSlug: .americanFootball)
    var n = 1
    var tabIndicator = UIView()
    
    weak var delegate: parentSportSlugPicker?
    
    override func addViews() {
        addSubview(tabsContainerView)
        
        tabsContainerView.addSubview(tabButtonFootball)
        tabsContainerView.addSubview(tabButtonBasketball)
        tabsContainerView.addSubview(tabButtonAmericanFootball)
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
        let tabWidth = UIScreen.main.bounds.width/3
        
        tabIndicator.snp.makeConstraints() {
            $0.height.equalTo(4)
            $0.width.equalTo(115)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo((n-1) * Int(tabWidth) + 8)
        }
        
        tabButtonFootball.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tabWidth)
            $0.leading.equalToSuperview()
        }
        
        tabButtonBasketball.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tabWidth)
            $0.leading.equalTo(tabButtonFootball.snp.trailing)
        }
        
        tabButtonAmericanFootball.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tabWidth)
            $0.leading.equalTo(tabButtonBasketball.snp.trailing)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapFootball = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
        tabButtonFootball.addGestureRecognizer(tapFootball)
        
        let tapBasketball = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
        tabButtonBasketball.addGestureRecognizer(tapBasketball)
        
        let tapAmericanFootball = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
        tabButtonAmericanFootball.addGestureRecognizer(tapAmericanFootball)
    }
    
    @objc func tabTapped(_ sender: UITapGestureRecognizer) {
        guard let tabItemView = sender.view as? TabItemView else { return }
        delegate?.getPressedTab(selectedSportSlug: tabItemView.sportSlug)
    }
}


