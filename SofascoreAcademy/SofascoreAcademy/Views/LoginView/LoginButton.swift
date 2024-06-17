import Foundation
import UIKit
import SnapKit
import SofaAcademic

class LoginButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupButton()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: private methods
private extension LoginButton {
    
    func setupButton() {
        setTitle("Login", for: .normal)
        titleLabel?.font = .action
        setTitleColor(.white, for: .normal)
    }
    
    func styleViews() {
        backgroundColor = .colorPrimaryDefault
        layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}
