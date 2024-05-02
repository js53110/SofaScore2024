import UIKit
import SofaAcademic
import SnapKit
import Foundation

class CustomTabView: BaseView {
    
    private let stackView = UIStackView()
    private let tabWidth = UIScreen.main.bounds.width/3
    private var tabButtonFootball = TabItemView(sportSlug: .football)
    private var tabButtonBasketball = TabItemView(sportSlug: .basketball)
    private var tabButtonAmericanFootball = TabItemView(sportSlug: .americanFootball)
    private var selectedIndex = 1
    private var tabIndicator = UIView()
    
    weak var delegate: ParentSportSlugPicker?
    init(sportSlug: sportSlug){
        switch sportSlug {
        case .football:
            selectedIndex = 1
        case .basketball:
            selectedIndex = 2
        case .americanFootball:
            selectedIndex = 3
        }
        super.init()
    }
    
    override func addViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(tabButtonFootball)
        stackView.addArrangedSubview(tabButtonBasketball)
        stackView.addArrangedSubview(tabButtonAmericanFootball)
        stackView.addSubview(tabIndicator)
    }
    
    override func styleViews() {
        backgroundColor = colors.colorPrimaryDefault
        tabIndicator.backgroundColor = .white
        tabIndicator.layer.cornerRadius = 2
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
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
        
        tabIndicator.snp.makeConstraints() {
            $0.height.equalTo(4)
            $0.width.equalTo(tabWidth - 16)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo((selectedIndex - 1) * Int(tabWidth) + 8)
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
        guard let tappedButton = sender.view as? TabItemView else { return }
        delegate?.displaySelectedSport(selectedSportSlug: tappedButton.sportSlug)
        moveIndicator(selectedTab: tappedButton)
    }
    
    private func moveIndicator(selectedTab: TabItemView) {
        
        UIView.animate(withDuration: 0.3) {
            self.tabIndicator.snp.remakeConstraints {
                $0.height.equalTo(4)
                $0.width.equalTo(self.tabWidth - 16)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(selectedTab.snp.leading).offset(8)
            }
            self.layoutIfNeeded()
        }
    }
}


