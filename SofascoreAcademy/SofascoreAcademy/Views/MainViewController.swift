import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MainViewController: UIViewController{
    
    private let sportViewController = SportViewController(sportSlug: .football)
    
    private let appHeader = AppHeader()
    private let customTabBarController = CustomTabView()
    
    private let blueContainer = UIView()
    private let containerView = UIView()
    private var currentChild = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        customTabBarController.delegate = self
        appHeader.delegate = self
    }
}

extension MainViewController : BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(appHeader)
        view.addSubview(customTabBarController)
        view.addSubview(containerView)
        currentChild = sportViewController
        addChild(child: sportViewController, parent: containerView)
    }
    
    func styleViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        blueContainer.backgroundColor = colors.colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        appHeader.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        customTabBarController.snp.makeConstraints() {
            $0.top.equalTo(appHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints() {
            $0.top.equalTo(customTabBarController.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: parentSportSlugPicker {
    
    func getPressedTab(selectedSportSlug: sportSlug?) {
        currentChild.remove()
        
        if let selectedSportSlug = selectedSportSlug {
            currentChild = SportViewController(sportSlug: selectedSportSlug)
            addChild(child: currentChild, parent: containerView)
        }
    }
}

extension MainViewController: settingsButtonTap {
    
    func reactToSetingsTap() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        settingsViewController.title = "Settings"
        present(settingsViewController, animated: true)
    }
}

extension MainViewController: DisplayMatchInfoOnTap {
    
    func displayMatchInfoOnTap() {
        print("qeq")
        navigationController?.pushViewController(MatchDataViewController(), animated: true)
    }
}




