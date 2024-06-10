import UIKit
import SofaAcademic
import SnapKit
import Foundation

class CustomTabView: BaseView {
    
    private let stackView = UIStackView()
    private var tabButtonFootball = TabItemView(sportSlug: .football)
    private var tabButtonBasketball = TabItemView(sportSlug: .basketball)
    private var tabButtonAmericanFootball = TabItemView(sportSlug: .americanFootball)
    private var tabIndicator = UIView()
    private var selectedTab: TabItemView
    
    weak var delegate: ParentSportSlugPicker?
    init(sportSlug: SportSlug){
        switch sportSlug {
        case .football:
            selectedTab = tabButtonFootball
        case .basketball:
            selectedTab = tabButtonBasketball
        case .americanFootball:
            selectedTab = tabButtonAmericanFootball
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
        backgroundColor = .colorPrimaryDefault
        stackView.distribution = .fillEqually
        tabIndicator.backgroundColor = .white
        tabIndicator.layer.cornerRadius = 2
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        tabIndicator.snp.makeConstraints() {
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(selectedTab.snp.trailing).inset(8)
            $0.leading.equalTo(selectedTab.snp.leading).offset(8)
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
}

//MARK: Private methods
private extension CustomTabView {
    
    @objc func tabTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedButton = sender.view as? TabItemView else { return }
        delegate?.displaySelectedSport(selectedSportSlug: tappedButton.sportSlug)
        moveIndicator(selectedTab: tappedButton)
    }
    
    func moveIndicator(selectedTab: TabItemView) {
        
        UIView.animate(withDuration: 0.3) {
            self.tabIndicator.snp.remakeConstraints {
                $0.height.equalTo(4)
                $0.bottom.equalToSuperview()
                $0.trailing.equalTo(selectedTab.snp.trailing).inset(8)
                $0.leading.equalTo(selectedTab.snp.leading).offset(8)
            }
            self.layoutIfNeeded()
        }
    }
}
