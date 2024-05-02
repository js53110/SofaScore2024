import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MainViewController: UIViewController {
    
    private let appHeader = AppHeader()
    private let customTabBar: CustomTabView
    private let blueContainer = UIView()
    private let containerView = UIView()
    private var currentChild: SportViewController
    private let savedSportSlug = UserDefaultsService.retrieveDataFromUserDefaults()
    
    init() {
        self.currentChild = SportViewController(sportSlug: savedSportSlug)
        self.customTabBar = CustomTabView(sportSlug: savedSportSlug)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        customTabBar.delegate = self
        appHeader.delegate = self
        currentChild.delegate = self
    }
}

// MARK: BaseViewProtocol
extension MainViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(appHeader)
        view.addSubview(customTabBar)
        view.addSubview(containerView)
        
        customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
    }
    
    func styleViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        blueContainer.backgroundColor = colors.colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        appHeader.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        customTabBar.snp.makeConstraints() {
            $0.top.equalTo(appHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints() {
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: ParentSportSlugPickerProtocol
extension MainViewController: ParentSportSlugPicker {
    
    func displaySelectedSport(selectedSportSlug: sportSlug?) {
        currentChild.remove()
        
        if let selectedSportSlug = selectedSportSlug {
            UserDefaultsService.saveDataToUserDefaults(sportSlug: selectedSportSlug)
            currentChild = SportViewController(sportSlug: selectedSportSlug)
            currentChild.delegate = self
            customAddChild(child: currentChild, parent: containerView, animation: Animations.pushFromRight())
        }
    }
}

// MARK: DidSettingsTapProtocol
extension MainViewController: AppHeaderDelegate {
    
    func reactToSetingsTap() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        settingsViewController.title = "Settings"
        present(settingsViewController, animated: true)
    }
}

// MARK: DisplayMatchInfoOnTapProtocol
extension MainViewController: MatchTapDelegate {
    
    func displayMatchInfoOnTap(selectedMatch: matchData) {
        navigationController?.pushViewController(MatchDataViewController(matchData: selectedMatch), animated: true)
    }
}
