import UIKit
import SofaAcademic
import SnapKit
import Foundation

class CustomTabView: BaseView {
    
    private let tabsContainerView = UIView()
    private let tabWidth = UIScreen.main.bounds.width/3
    private var tabButtonFootball = TabItemView(sportSlug: .football)
    private var tabButtonBasketball = TabItemView(sportSlug: .basketball)
    private var tabButtonAmericanFootball = TabItemView(sportSlug: .americanFootball)
    private var n = 1 //chosen tab id
    private var tabIndicator = UIView()
    
    weak var delegate: parentSportSlugPicker?
    init(sportSlug: sportSlug){
        switch sportSlug {
        case .football:
            n = 1
        case .basketball:
            n = 2
        case .americanFootball:
            n = 3
        }
        super.init()
    }
    
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
            $0.width.equalTo(115)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo((n-1) * Int(tabWidth) + 8)
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
        //        postoji bolji nacin za ovo???
        UIView.animate(withDuration: 0.3) { [self] in
            switch tabItemView {
            case self.tabButtonFootball:
                self.tabIndicator.snp.remakeConstraints {
                    $0.height.equalTo(4)
                    $0.width.equalTo(tabWidth-16)
                    $0.bottom.equalToSuperview()
                    $0.leading.equalTo(self.tabButtonFootball.snp.leading).offset(8)
                }
            case self.tabButtonBasketball:
                self.tabIndicator.snp.remakeConstraints {
                    $0.height.equalTo(4)
                    $0.width.equalTo(tabWidth-16)
                    $0.bottom.equalToSuperview()
                    $0.leading.equalTo(self.tabButtonBasketball.snp.leading).offset(8)
                }
            case self.tabButtonAmericanFootball:
                self.tabIndicator.snp.remakeConstraints {
                    $0.height.equalTo(4)
                    $0.width.equalTo(tabWidth-16)
                    $0.bottom.equalToSuperview()
                    $0.leading.equalTo(self.tabButtonAmericanFootball.snp.leading).offset(8)
                }
            default:
                break
            }
            self.layoutIfNeeded()
        }
    }
}


