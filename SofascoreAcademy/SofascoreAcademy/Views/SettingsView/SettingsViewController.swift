import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SettingsViewController: UIViewController {
    
    private let blueContainer = UIView()
    private let settingsHeader = SettingsHeaderView()
    private let aboutView = SettingsAboutView()
    
    private let appLogo = UIImageView(image: UIImage(named: "sofascore_logo_blue"))
    
    private let logoutView = UIView()
    private let logoutText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
        settingsHeader.eventDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: BaseViewProtocol
extension SettingsViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(settingsHeader)
        view.addSubview(aboutView)
        view.addSubview(logoutView)
        logoutView.addSubview(logoutText)
        view.addSubview(appLogo)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        blueContainer.backgroundColor = .colorPrimaryDefault
        settingsHeader.backgroundColor = .colorPrimaryDefault
        logoutView.backgroundColor = .colorPrimaryDefault
        logoutView.layer.cornerRadius = 10.0
        logoutView.layer.masksToBounds = true
        logoutText.text = "Logout"
        logoutText.font = .action
        logoutText.textColor = .white
        logoutText.textAlignment = .center
        appLogo.contentMode = .scaleAspectFit
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        settingsHeader.snp.makeConstraints {
            $0.top.equalTo(blueContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        aboutView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(settingsHeader.snp.bottom)
            $0.height.equalTo(380)
        }
        
        logoutView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(64)
            $0.height.equalTo(48)
            $0.top.equalTo(aboutView.snp.bottom).offset(16)
        }
        
        logoutText.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        appLogo.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(114)
            $0.height.equalTo(20)
        }
    }
    
    func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoutButtonTapped))
        logoutView.addGestureRecognizer(tapGesture)
    }
}

extension SettingsViewController: ReturnButtonDelegate {
    func reactToReturnTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController {
    @objc func logoutButtonTapped() {
        Keychain.deleteTokenFromKeychain(token: "academy_token")
        navigationController?.popToRootViewController(animated: true)
    }
}
