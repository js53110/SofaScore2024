import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LoadingViewController: UIViewController, BaseViewProtocol {
    
    let appLogo = UIImageView(image: UIImage(named: "sofascore_logo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayViewController()
    }
    
    func setupView() {
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(appLogo)
    }
    
    func styleViews() {
        view.backgroundColor = .colorPrimaryDefault
        appLogo.contentMode = .scaleAspectFit
    }
    
    func setupConstraints() {
        appLogo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(132)
        }
    }
}

extension LoadingViewController {
    
    func displayViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let loggedIn = Keychain.isTokenExistingInKeychain(token: "academy_token")
            
            if loggedIn {
                let mainViewController = MainViewController()
                self.navigationController?.pushViewController(mainViewController, animated: true)
            } else {
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)

            }
        }
    }
}
