import UIKit
import SnapKit
import SofaAcademic

class SettingsViewController: UIViewController {
    
    private let blueContainer = UIView()
    private let dismissButton = UIButton() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        view.backgroundColor = .black
        
        addViews()
        styleViews()
        setupConstraints()
    }
}

extension SettingsViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(dismissButton)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        blueContainer.backgroundColor = colors.colorPrimaryDefault
        
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(colors.colorPrimaryDefault, for: .normal)
        dismissButton.titleLabel?.font = fonts.RobotoRegular14
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        dismissButton.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

extension SettingsViewController {
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
