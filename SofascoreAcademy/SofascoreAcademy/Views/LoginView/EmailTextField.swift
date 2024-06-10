import Foundation
import UIKit
import SnapKit
import SofaAcademic

class EmailTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupTextView()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: private methods
private extension EmailTextField {
    
    func setupTextView() {
        attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.onSurfaceOnSurfaceLv2])
        keyboardType = .emailAddress
        borderStyle = .roundedRect
        textContentType = .oneTimeCode
        autocapitalizationType = .none
        returnKeyType = .done
        backgroundColor = .white
        textColor = .black
    }
    
    func styleViews() {
        layer.cornerRadius = 13
        layer.masksToBounds = true
    }
    
    func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}
