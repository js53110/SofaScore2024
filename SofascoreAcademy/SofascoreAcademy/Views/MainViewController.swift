import Foundation
import UIKit
import SofaAcademic
import SnapKit



protocol settingsButtonTap {
    
    func reactToSetingsTap()
}

protocol tableCellTap {
    
    func reactToCellTap(match: matchData)
}

class MainViewController: UIViewController, SettingsButtonTapDelegate {
    
    private let sportViewController = SportViewController(sportSlug: .football)
    
    private let appHeader = AppHeader()
    private let customTabBarController = CustomTabBarController()
    
    private let blueContainer = UIView()
    private let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        customTabBarController.delegate = self
        appHeader.delegate = self
        //        footballViewController?.delegate = self
    }
}

extension MainViewController : BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(appHeader)
        view.addSubview(customTabBarController)
        view.addSubview(containerView)
        
        addChild(child: sportViewController, parent: containerView)
    }
    
    func styleViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        blueContainer.backgroundColor = colors.colorPrimaryDefault
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints() {
            $0.top.equalTo(customTabBarController.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        customTabBarController.snp.makeConstraints() {
            $0.top.equalTo(appHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        appHeader.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

extension MainViewController: parentSportSlugPicker {
    
    func getPressedTab(selectedSportSlug: sportSlug?) {
        let snapshot = sportViewController.view.snapshotView(afterScreenUpdates: true)!
        snapshot.frame = containerView.bounds
        
        sportViewController.remove()
        
        if let selectedSportSlug = selectedSportSlug {
            addChild(child: SportViewController(sportSlug: selectedSportSlug), parent: containerView)
        }
        containerView.addSubview(snapshot)
        UIView.transition(from: snapshot, to: sportViewController.view, duration: 0.3, options: .transitionCrossDissolve) { _ in
            snapshot.removeFromSuperview()
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

extension MainViewController: tableCellTap {
    func reactToCellTap(match: matchData) {
        navigationController?.pushViewController(MatchDataViewController(), animated: true)
    }
}


