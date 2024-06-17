import Foundation
import UIKit
import SnapKit
import SofaAcademic

class PasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupTextField()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: private methods
private extension PasswordTextField {
    
    func setupTextField() {
        attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.onSurfaceOnSurfaceLv2])
        isSecureTextEntry = true
        textContentType = .oneTimeCode
        borderStyle = .roundedRect
        autocapitalizationType = .none
        returnKeyType = .done
        backgroundColor = .white
        textColor = .black
    }
    
    func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
    func styleViews() {
        layer.cornerRadius = 13
        layer.masksToBounds = true
    }
}
