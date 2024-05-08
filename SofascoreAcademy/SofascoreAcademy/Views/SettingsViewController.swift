import UIKit
import SnapKit
import SofaAcademic

class SettingsViewController: UIViewController {
    
    private let blueContainer = UIView()
    private let dismissButton = UIButton() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
    }
}

// MARK: BaseViewProtocol
extension SettingsViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
        view.addSubview(dismissButton)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        blueContainer.backgroundColor = Colors.colorPrimaryDefault
        
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(Colors.colorPrimaryDefault, for: .normal)
        dismissButton.titleLabel?.font = Fonts.RobotoRegular14
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

// MARK: Private methods
private extension SettingsViewController {
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
