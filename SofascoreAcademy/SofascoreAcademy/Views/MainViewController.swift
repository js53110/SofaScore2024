import Foundation
import UIKit
import SofaAcademic
import SnapKit

protocol parentSportSlugPicker {
    func getPressedTab(request: sport_slug?)
}

protocol settingsButtonTap {
    func reactToSetingsTap()
}

protocol tableCellTap {
    func reactToCellTap(match: matchData)
}

enum sport_slug {
    case football
    case basketball
    case american_football
}

class MainViewController : UIViewController {
    
    private let footballViewController = FootballViewController()
    private let basketballViewController = BasketballViewController()
    private let americanFootballViewController = AmericanFootballViewController()
    
    private let appHeader = AppHeader()
    private let customTabBarController = CustomTabBarController()
    
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
        footballViewController.delegate = self
        basketballViewController.delegate = self
        americanFootballViewController.delegate = self
    }
}

extension UIViewController {
    
    func addChild(child: UIViewController, parent: UIView) {
        addChild(child)
        parent.addSubview(child.view)
        child.view.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension MainViewController : BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(appHeader)
        view.addSubview(customTabBarController)
        view.addSubview(containerView)
        
        currentChild = footballViewController
        addChild(child: currentChild, parent: containerView)
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
    
    func getPressedTab(request: sport_slug?) {
        let snapshot = currentChild.view.snapshotView(afterScreenUpdates: true)!
        snapshot.frame = containerView.bounds
        
        currentChild.remove()
        
        if let request = request {
            switch request {
            case .football:
                addChild(child: footballViewController, parent: containerView)
                currentChild = footballViewController
            case .basketball:
                addChild(child: basketballViewController, parent: containerView)
                currentChild = basketballViewController
            case .american_football:
                addChild(child: americanFootballViewController, parent: containerView)
                currentChild = americanFootballViewController
            }
        }
        containerView.addSubview(snapshot)
        UIView.transition(from: snapshot, to: currentChild.view, duration: 0.3, options: .transitionCrossDissolve) { _ in
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


